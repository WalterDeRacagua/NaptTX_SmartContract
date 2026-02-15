// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
contract OfflinePaymentSystem is ERC20 {

    // =========================
    // VARIABLES Y ESTRUCTURAS
    // =========================
    /**
     * PREPARADO: Fase 1: fondos reservados
     * CONFIRMADO: Fase 2: pago completado
     * REVERTIDO: Timeout: pago cancelado
     * FALLIDO: Error en el procesamiento
     */
    enum Estado {PREPARADO, CONFIRMADO, REVERTIDO, FALLIDO}
    uint256 public constant TIMEOUT_PAGO = 2 minutes;

    struct Emisor {
        address walletAddress;
        bytes32 hashActual;
        mapping (address => uint256) whitelist; 
        uint256 timestampUltimoPago;
        bool registrado;
        bytes32 deviceId;
    }

    struct PagoPendiente {
        bytes32 idPago;
        address emisor;
        address receptor;
        uint256 amount;
        bytes32 hashUsado;
        bytes32 hashPreparado;
        bytes32 hashFinal;
        uint256 timestampPreparacion;
        uint256 timestampConfirmacion;
        Estado estado;
        bytes32 transaccionId;
    }

    mapping(address => Emisor) public emisores;
    mapping(bytes32 => PagoPendiente) public pagosPendientes;
    mapping(address => mapping(uint256 => bool)) public noncesUsados;
    mapping(bytes32 => bool) public devicesIdsUsados;
    

    constructor () ERC20("NapTx Token", "NPTX"){}

    // =========================
    // FUNCIONES - CASOS DE USO
    // =========================

    function registrar(uint256 timestamp, uint256 nonce, bytes memory firma) external returns (bytes32 hashInicial){
        address emisor = msg.sender;
        require(!emisores[emisor].walletAddress, "Ya registrado");
        require(!)
        
    }

    // =========================
    // EVENTOS
    // =========================
    event emisorRegistrado(address indexed emisor, bytes32 hashInicial, uint256 timestamp);
    event PagoPreparado(bytes32 indexed pagoId, address indexed emisor, address indexed receptor, uint256 amount, bytes32 hashPreparado, uint256 timestamp);
    event PagoConfirmado(bytes32 indexed pagoId, address indexed emisor, address indexed receptor, uint256 amount, bytes32 hashFinal,uint256 timestamp);
    event PagoRevertido(bytes32 indexed pagoId, address indexed emisor, address indexed receptor, uint256 amount,uint256 timestamp);
    //Quizás sería  mejor que recibiera un map de receptores => limites
    event WhitelistConfigurada(address indexed emisor, address[] receptores, uint256[] limites, uint256 timestamp);


}