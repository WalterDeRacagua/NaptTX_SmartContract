// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
contract OfflinePaymentSystem is ERC20 {

    constructor () ERC20("NapTx Token", "NPTX"){}
}