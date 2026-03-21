
// File: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol


// OpenZeppelin Contracts (last updated v5.4.0) (token/ERC20/IERC20.sol)

pragma solidity >=0.4.16;

/**
 * @dev Interface of the ERC-20 standard as defined in the ERC.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the
     * allowance mechanism. `value` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

// File: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/IERC20Metadata.sol


// OpenZeppelin Contracts (last updated v5.4.0) (token/ERC20/extensions/IERC20Metadata.sol)

pragma solidity >=0.6.2;


/**
 * @dev Interface for the optional metadata functions from the ERC-20 standard.
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

// File: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Context.sol


// OpenZeppelin Contracts (last updated v5.0.1) (utils/Context.sol)

pragma solidity ^0.8.20;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    function _contextSuffixLength() internal view virtual returns (uint256) {
        return 0;
    }
}

// File: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/interfaces/draft-IERC6093.sol


// OpenZeppelin Contracts (last updated v5.5.0) (interfaces/draft-IERC6093.sol)

pragma solidity >=0.8.4;

/**
 * @dev Standard ERC-20 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC-20 tokens.
 */
interface IERC20Errors {
    /**
     * @dev Indicates an error related to the current `balance` of a `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param balance Current balance for the interacting account.
     * @param needed Minimum amount required to perform a transfer.
     */
    error ERC20InsufficientBalance(address sender, uint256 balance, uint256 needed);

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC20InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC20InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `spender`’s `allowance`. Used in transfers.
     * @param spender Address that may be allowed to operate on tokens without being their owner.
     * @param allowance Amount of tokens a `spender` is allowed to operate with.
     * @param needed Minimum amount required to perform a transfer.
     */
    error ERC20InsufficientAllowance(address spender, uint256 allowance, uint256 needed);

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC20InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `spender` to be approved. Used in approvals.
     * @param spender Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC20InvalidSpender(address spender);
}

/**
 * @dev Standard ERC-721 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC-721 tokens.
 */
interface IERC721Errors {
    /**
     * @dev Indicates that an address can't be an owner. For example, `address(0)` is a forbidden owner in ERC-721.
     * Used in balance queries.
     * @param owner Address of the current owner of a token.
     */
    error ERC721InvalidOwner(address owner);

    /**
     * @dev Indicates a `tokenId` whose `owner` is the zero address.
     * @param tokenId Identifier number of a token.
     */
    error ERC721NonexistentToken(uint256 tokenId);

    /**
     * @dev Indicates an error related to the ownership over a particular token. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param tokenId Identifier number of a token.
     * @param owner Address of the current owner of a token.
     */
    error ERC721IncorrectOwner(address sender, uint256 tokenId, address owner);

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC721InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC721InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `operator`’s approval. Used in transfers.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     * @param tokenId Identifier number of a token.
     */
    error ERC721InsufficientApproval(address operator, uint256 tokenId);

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC721InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `operator` to be approved. Used in approvals.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC721InvalidOperator(address operator);
}

/**
 * @dev Standard ERC-1155 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC-1155 tokens.
 */
interface IERC1155Errors {
    /**
     * @dev Indicates an error related to the current `balance` of a `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param balance Current balance for the interacting account.
     * @param needed Minimum amount required to perform a transfer.
     * @param tokenId Identifier number of a token.
     */
    error ERC1155InsufficientBalance(address sender, uint256 balance, uint256 needed, uint256 tokenId);

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC1155InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC1155InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `operator`’s approval. Used in transfers.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     * @param owner Address of the current owner of a token.
     */
    error ERC1155MissingApprovalForAll(address operator, address owner);

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC1155InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `operator` to be approved. Used in approvals.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC1155InvalidOperator(address operator);

    /**
     * @dev Indicates an array length mismatch between ids and values in a safeBatchTransferFrom operation.
     * Used in batch transfers.
     * @param idsLength Length of the array of token identifiers
     * @param valuesLength Length of the array of token amounts
     */
    error ERC1155InvalidArrayLength(uint256 idsLength, uint256 valuesLength);
}

// File: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol


// OpenZeppelin Contracts (last updated v5.5.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.20;





/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.openzeppelin.com/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * The default value of {decimals} is 18. To change this, you should override
 * this function so it returns a different value.
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC-20
 * applications.
 */
abstract contract ERC20 is Context, IERC20, IERC20Metadata, IERC20Errors {
    mapping(address account => uint256) private _balances;

    mapping(address account => mapping(address spender => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * Both values are immutable: they can only be set once during construction.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the default value returned by this function, unless
     * it's overridden.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual returns (uint8) {
        return 18;
    }

    /// @inheritdoc IERC20
    function totalSupply() public view virtual returns (uint256) {
        return _totalSupply;
    }

    /// @inheritdoc IERC20
    function balanceOf(address account) public view virtual returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - the caller must have a balance of at least `value`.
     */
    function transfer(address to, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, value);
        return true;
    }

    /// @inheritdoc IERC20
    function allowance(address owner, address spender) public view virtual returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `value` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, value);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Skips emitting an {Approval} event indicating an allowance update. This is not
     * required by the ERC. See {xref-ERC20-_approve-address-address-uint256-bool-}[_approve].
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `value`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `value`.
     */
    function transferFrom(address from, address to, uint256 value) public virtual returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead.
     */
    function _transfer(address from, address to, uint256 value) internal {
        if (from == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        if (to == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        _update(from, to, value);
    }

    /**
     * @dev Transfers a `value` amount of tokens from `from` to `to`, or alternatively mints (or burns) if `from`
     * (or `to`) is the zero address. All customizations to transfers, mints, and burns should be done by overriding
     * this function.
     *
     * Emits a {Transfer} event.
     */
    function _update(address from, address to, uint256 value) internal virtual {
        if (from == address(0)) {
            // Overflow check required: The rest of the code assumes that totalSupply never overflows
            _totalSupply += value;
        } else {
            uint256 fromBalance = _balances[from];
            if (fromBalance < value) {
                revert ERC20InsufficientBalance(from, fromBalance, value);
            }
            unchecked {
                // Overflow not possible: value <= fromBalance <= totalSupply.
                _balances[from] = fromBalance - value;
            }
        }

        if (to == address(0)) {
            unchecked {
                // Overflow not possible: value <= totalSupply or value <= fromBalance <= totalSupply.
                _totalSupply -= value;
            }
        } else {
            unchecked {
                // Overflow not possible: balance + value is at most totalSupply, which we know fits into a uint256.
                _balances[to] += value;
            }
        }

        emit Transfer(from, to, value);
    }

    /**
     * @dev Creates a `value` amount of tokens and assigns them to `account`, by transferring it from address(0).
     * Relies on the `_update` mechanism
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead.
     */
    function _mint(address account, uint256 value) internal {
        if (account == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        _update(address(0), account, value);
    }

    /**
     * @dev Destroys a `value` amount of tokens from `account`, lowering the total supply.
     * Relies on the `_update` mechanism.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead
     */
    function _burn(address account, uint256 value) internal {
        if (account == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        _update(account, address(0), value);
    }

    /**
     * @dev Sets `value` as the allowance of `spender` over the `owner`'s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     *
     * Overrides to this logic should be done to the variant with an additional `bool emitEvent` argument.
     */
    function _approve(address owner, address spender, uint256 value) internal {
        _approve(owner, spender, value, true);
    }

    /**
     * @dev Variant of {_approve} with an optional flag to enable or disable the {Approval} event.
     *
     * By default (when calling {_approve}) the flag is set to true. On the other hand, approval changes made by
     * `_spendAllowance` during the `transferFrom` operation sets the flag to false. This saves gas by not emitting any
     * `Approval` event during `transferFrom` operations.
     *
     * Anyone who wishes to continue emitting `Approval` events on the `transferFrom` operation can force the flag to
     * true using the following override:
     *
     * ```solidity
     * function _approve(address owner, address spender, uint256 value, bool) internal virtual override {
     *     super._approve(owner, spender, value, true);
     * }
     * ```
     *
     * Requirements are the same as {_approve}.
     */
    function _approve(address owner, address spender, uint256 value, bool emitEvent) internal virtual {
        if (owner == address(0)) {
            revert ERC20InvalidApprover(address(0));
        }
        if (spender == address(0)) {
            revert ERC20InvalidSpender(address(0));
        }
        _allowances[owner][spender] = value;
        if (emitEvent) {
            emit Approval(owner, spender, value);
        }
    }

    /**
     * @dev Updates `owner`'s allowance for `spender` based on spent `value`.
     *
     * Does not update the allowance value in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Does not emit an {Approval} event.
     */
    function _spendAllowance(address owner, address spender, uint256 value) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance < type(uint256).max) {
            if (currentAllowance < value) {
                revert ERC20InsufficientAllowance(spender, currentAllowance, value);
            }
            unchecked {
                _approve(owner, spender, currentAllowance - value, false);
            }
        }
    }
}

// File: NapTx.sol


pragma solidity ^0.8.20;

contract OfflinePaymentSystem is ERC20 {

    uint256 public constant TIMEOUT_PAGO = 10 minutes;
    uint256 public constant TIMESTAMP_TOLERANCE = 5 minutes;
    uint256 public constant PRECIO_POR_TOKEN = 1 ether;

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
    

    constructor () ERC20("NapTx Token", "NPTX") payable {
        _mint(address(this), 1000000 * 10**decimals());
        require(msg.value > 0, "Debe enviar ETH inicial para liquidez");
    }


    // =========================
    // FUNCIONES - CASOS DE USO
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

        emit PagoPreparado(pagoId, emisor, receptor, amount, hashPreparado, block.timestamp);

        return (pagoId, hashPreparado);
    }

    function confirmarPago(bytes32 pagoId, bytes32 hashPreparado, bytes calldata firmaConfirmacion) external returns (bytes32 hashFinal) {
        PagoPendiente storage pago = pagosPendientes[pagoId];

        require(pago.emisor != address(0), "Pago no existe");
        require(pago.estado == Estado.PREPARADO, "Pago no preparado");
        require(pago.hashPreparado == hashPreparado, "Hash preparado invalido");
        require(block.timestamp <= pago.timestampPreparacion + TIMEOUT_PAGO, "Pago expirado");

        bytes32 mensaje = keccak256(abi.encodePacked(
            pagoId,
            hashPreparado,
            "confirmar"
        ));

        address firmante = recuperarFirmante(mensaje, firmaConfirmacion);
        require(firmante == pago.emisor, "Confirmacion invalida");

        _transfer(pago.emisor, pago.receptor, pago.amount);

        hashFinal = keccak256(abi.encodePacked(
            pago.hashUsado,
            pago.amount,
            pago.receptor,
            pago.timestampPreparacion,  
            "confirmado"
        ));

        emisores[pago.emisor].hashActual = hashFinal;
        emisores[pago.emisor].timestampUltimoPago = block.timestamp;

        emisores[pago.emisor].whitelist[pago.receptor] -= pago.amount;

        require(allowance(pago.emisor, address(this)) >= pago.amount, "Allowance insuficiente");
        _approve(pago.emisor, address(this), allowance(pago.emisor, address(this)) - pago.amount);

        pago.hashFinal = hashFinal;
        pago.timestampConfirmacion = block.timestamp;
        pago.estado = Estado.CONFIRMADO;

        emit PagoConfirmado(pagoId, pago.emisor, pago.receptor, pago.amount, hashFinal, block.timestamp);

        return hashFinal;
    }

    function revertirPago(bytes32 pagoId) external {
        PagoPendiente storage pago = pagosPendientes[pagoId];

        require(pago.emisor != address(0), "Pago no existe");
        require(pago.estado == Estado.PREPARADO, "Pago no preparado");
        require(block.timestamp > pago.timestampPreparacion + TIMEOUT_PAGO, "Pago no expirado aun");

        pago.estado = Estado.REVERTIDO;
        

        emit PagoRevertido(pagoId, pago.emisor, pago.receptor, pago.amount, block.timestamp);
    }

    function obtenerEstadoEmisor(address emisor) external view returns (bytes32 hashActual, bool registrado, uint256 timestampUltimoPago, bytes32 deviceId) {
        Emisor storage e = emisores[emisor];

        return (e.hashActual, e.registrado, e.timestampUltimoPago, e.deviceId);
    }

    function obtenerLimiteWhitelist(address emisor, address receptor) external view returns (uint256) {
        return emisores[emisor].whitelist[receptor];
    }

    // ====================================================================
    // FUNCIONES - COMPRAR Y VENDER TOKENS PARA HACER PAGOS Y RECIBIR ETHER
    // ====================================================================
    function comprarTokens() external payable {
        require(msg.value > 0, "Debes enviar ETH");
        
        uint256 tokensAComprar = (msg.value * 10**decimals()) / PRECIO_POR_TOKEN;
        
        require(tokensAComprar > 0, "ETH insuficiente para comprar tokens");
        require(balanceOf(address(this)) >= tokensAComprar, "No hay suficientes tokens en reserva");
        
        // Transferir tokens al comprador
        _transfer(address(this), msg.sender, tokensAComprar);
        
        emit TokensComprados(msg.sender, tokensAComprar, msg.value);
    }

    function venderTokens(uint256 cantidad) external {
        require(cantidad > 0, "Cantidad debe ser mayor a 0");
        require(balanceOf(msg.sender) >= cantidad, "Balance insuficiente");
        
        uint256 ethADevolver = (cantidad * PRECIO_POR_TOKEN) / 10**decimals();
        
        require(ethADevolver > 0, "Cantidad muy pequena para vender");
        require(address(this).balance >= ethADevolver, "Contrato sin ETH suficiente");
        
        _transfer(msg.sender, address(this), cantidad);
        
        // Transferir ETH al vendedor
        (bool success, ) = payable(msg.sender).call{value: ethADevolver}("");
        require(success, "Transfer de ETH fallo");
    
        emit TokensVendidos(msg.sender, cantidad, ethADevolver);
    }

    receive() external payable {
        emit ETHRecibido(msg.sender, msg.value);
    }


    function obtenerBalanceETHContrato() external view returns (uint256) {
        return address(this).balance;
    }

    function obtenerBalanceTokensContrato() external view returns (uint256) {
        return balanceOf(address(this));
    }

    function transferFrom(address , address , uint256 ) public virtual override returns (bool) { 
        revert("transferFrom deshabilitado - el sistema usa _transfer internamente");
    }

    function transfer(address , uint256 ) public virtual override returns (bool) {
        revert("transfer deshabilitado - usar sistema de pagos offline");
    }
    function increaseAllowance(address , uint256 ) public pure returns (bool) {
        revert("Use configurarWhitelist para gestionar allowance");
    }

    function decreaseAllowance(address , uint256 ) public pure returns (bool) {
        revert("Use configurarWhitelist para gestionar allowance");
    }

    // EVENTOS
    event EmisorRegistrado(address indexed emisor, bytes32 deviceId, bytes32 hashInicial, uint256 timestamp);
    event PagoPreparado(bytes32 indexed pagoId, address indexed emisor, address indexed receptor, uint256 amount, bytes32 hashPreparado, uint256 timestamp);
    event PagoConfirmado(bytes32 indexed pagoId, address indexed emisor, address indexed receptor, uint256 amount, bytes32 hashFinal,uint256 timestamp);
    event PagoRevertido(bytes32 indexed pagoId, address indexed emisor, address indexed receptor, uint256 amount,uint256 timestamp);
    event WhitelistConfigurada(address indexed emisor, address[] receptores, uint256[] limites, uint256 timestamp);
    event TokensComprados(address indexed comprador, uint256 cantidadTokens, uint256 ethGastado);
    event TokensVendidos(address indexed vendedor, uint256 cantidadTokens, uint256 ethRecibido);
    event ETHRecibido(address indexed enviador, uint256 cantidad);
}