// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
contract OfflinePaymentSystem is ERC20 {

    uint256 public constant TIMEOUT_PAGO = 10 minutes;
    uint256 public constant TIMESTAMP_TOLERANCE = 5 minutes;

    enum Estado {PREPARADO, CONFIRMADO, REVERTIDO, FALLIDO}

    struct Emisor {
        address walletAddress;
        bytes32 hashActual;
        mapping (address => uint256) whitelist; 
        uint256 timestampUltimoPago;
        bool registrado;
        bytes32 deviceId;
    }

    struct PagoPendiente {
        bytes32 pagoId;
        address emisor;
        address receptor;
        uint256 amount;
        bytes32 hashUsado;
        bytes32 hashPreparado;
        bytes32 hashFinal;
        uint256 timestampPreparacion;
        uint256 timestampConfirmacion;
        Estado estado;
        bytes32 txId;
    }

    mapping(address => Emisor) public emisores;
    mapping(bytes32 => PagoPendiente) public pagosPendientes;
    mapping(address => mapping(uint256 => bool)) public noncesUsados;
    mapping(bytes32 => bool) public deviceIdsUsados;
    

    constructor () ERC20("NapTx Token", "NPTX"){
        _mint(msg.sender, 1000 * 10**10);
    }


    // =========================
    // FUNCIONES - CASOS DE USO --> es pure porque no lle ni modifica datos de la blockchain.
    // =========================
    function registrar(bytes32 deviceId, uint256 timestamp, uint256 nonce, bytes calldata firma) external returns (bytes32 hashInicial){
        address emisor = msg.sender;
        require(!emisores[emisor].registrado, "Ya registrado");
        require(!deviceIdsUsados[deviceId], "Device ya usado");
        require(block.timestamp <= timestamp +TIMESTAMP_TOLERANCE, "Timestamp expirado");

        //VERIFICAMOS LA FIRMA
        bytes32 mensaje = keccak256(abi.encodePacked(
            emisor,
            deviceId,
            timestamp,
            nonce
        ));

        address firmante = recuperarFirmante(mensaje, firma);
        require(firmante == emisor, "Firma invalida");

        //GENERAR HASH INICIAL
        hashInicial = keccak256(abi.encodePacked(
            emisor,
            deviceId,
            block.timestamp,
            "genesis"
        ));

        //GUARDAR EMISOR
        emisores[emisor].walletAddress = emisor;
        emisores[emisor].hashActual = hashInicial;
        emisores[emisor].deviceId = deviceId;
        emisores[emisor].timestampUltimoPago = 0;
        emisores[emisor].registrado = true;

        //MARCAR COMO USADOS
        deviceIdsUsados[deviceId] = true;
        noncesUsados[emisor][nonce] = true;

        emit EmisorRegistrado(emisor, deviceId, hashInicial, block.timestamp);  

        return hashInicial;      
    }

    // =========================
    // FUNCIONES HELPER
    // =========================
    function recuperarFirmante(bytes32 mensaje, bytes memory firma) internal pure returns (address)
    {
        require(firma.length == 65, "Firma invalida");

        bytes32 r;
        bytes32 s;
        uint8 v;

        assembly {
            r := mload(add(firma,32)) //Lee 32 bytes desde la posicion 32 (los 32 priemeros son metadata de solidity)
            s := mload(add(firma,64)) //Lee 32 bytes desde la posicion 64 
            v := byte(0,mload(add(firma, 96))) //Lee 1 byte desde la posicion 96
        }


        /**
        * En Ethereum, v SIEMPRE debe ser 27 o 28. Pero algunas librerias (como Android KeyStore) generan v como 0 o 1.
        * Solución:
        *    Si v = 0 → v = 0 + 27 = 27 
        *    Si v = 1 → v = 1 + 27 = 28 
        *    Si v ya es 27 o 28 → No se modifica
        */
        if (v < 27) {
            v += 27;
        }

        require(v == 27 || v == 28, "v invalido");


        //Extrae el address de el que firmo
        return ecrecover(mensaje, v, r, s);
    }

    function configurarWhitelist(address[] memory receptores, uint256[] calldata limites,uint256 timestamp, uint256 nonce, bytes calldata firma) external {
        address emisor = msg.sender;

        require(emisores[emisor].registrado, "No registrado");
        require(receptores.length == limites.length, "Longitudes diferentes");
        require(block.timestamp <= timestamp + TIMESTAMP_TOLERANCE, "Timestamp expirado");
        require(!noncesUsados[emisor][nonce], "Nonce ya usado");

        bytes32 mensaje = keccak256(abi.encodePacked(
            receptores,
            limites,
            timestamp,
            nonce
        ));

        address firmante = recuperarFirmante(mensaje, firma);
        require(firmante == emisor, "Firma invalida");

        uint256 sumaTotal =0;
        for (uint i =0; i < receptores.length; i++) 
        {
            sumaTotal += limites[i];
        }

        uint256 allowanceActual = allowance(emisor, address(this));
        require(sumaTotal <= allowanceActual, "Suma > allowance");

        for (uint i =0; i < receptores.length; i++) 
        {
            emisores[emisor].whitelist[receptores[i]] = limites[i];
        }

        noncesUsados[emisor][nonce] = true;

        emit WhitelistConfigurada(emisor, receptores, limites, timestamp);
    }

    function prepararPago(bytes32 hashUsado, uint256 amount, address receptor, uint256 timestamp, uint256 nonce, bytes32 deviceId,
        bytes calldata firma) external returns (bytes32 pagoId, bytes32 hashPreparado) {
        
        bytes32 mensaje = keccak256(abi.encodePacked(
            hashUsado,
            amount,
            receptor,
            timestamp,
            nonce,
            deviceId
        ));

        address emisor = recuperarFirmante(mensaje, firma);

        require(emisores[emisor].registrado, "No registrado");
        require(emisores[emisor].hashActual == hashUsado, "Hash invalido");
        require(emisores[emisor].deviceId == deviceId, "Device invalido");
        require(block.timestamp <= timestamp + TIMESTAMP_TOLERANCE, "Timestamp expirado");
        require(!noncesUsados[emisor][nonce], "Nonce ya usado");
        require(emisores[emisor].whitelist[receptor] >= amount, "Excede limites");

        require(allowance(emisor, address(this)) >= amount, "Allowance insuficiente");
        require(balanceOf(emisor) >= amount, "Balance insuficiente");

        pagoId = keccak256(abi.encodePacked(
           emisor,
           receptor,
           amount,
           hashUsado,
           block.timestamp,
           nonce
        ));
        
        require(pagosPendientes[pagoId].emisor == address(0), "Pago ya existente");

        hashPreparado = keccak256(abi.encodePacked(
            hashUsado,
            "preparado",
            pagoId,
            block.timestamp
        ));

        pagosPendientes[pagoId].pagoId = pagoId;
        pagosPendientes[pagoId].emisor = emisor;
        pagosPendientes[pagoId].receptor = receptor;
        pagosPendientes[pagoId].amount = amount;
        pagosPendientes[pagoId].hashUsado = hashUsado;
        pagosPendientes[pagoId].hashPreparado = hashPreparado;
        pagosPendientes[pagoId].timestampPreparacion = block.timestamp;
        pagosPendientes[pagoId].estado = Estado.PREPARADO;

        noncesUsados[emisor][nonce] = true;

        emit PagoPreparado(pagoId, emisor, receptor, amount, hashPreparado, timestamp);

        return (pagoId, hashPreparado);
    }

    // =========================
    // EVENTOS
    // =========================
    event EmisorRegistrado(address indexed emisor, bytes32 deviceId, bytes32 hashInicial, uint256 timestamp);
    event PagoPreparado(bytes32 indexed pagoId, address indexed emisor, address indexed receptor, uint256 amount, bytes32 hashPreparado, uint256 timestamp);
    event PagoConfirmado(bytes32 indexed pagoId, address indexed emisor, address indexed receptor, uint256 amount, bytes32 hashFinal,uint256 timestamp);
    event PagoRevertido(bytes32 indexed pagoId, address indexed emisor, address indexed receptor, uint256 amount,uint256 timestamp);
    event WhitelistConfigurada(address indexed emisor, address[] receptores, uint256[] limites, uint256 timestamp);
}