// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TestHash {
    
    function calcularHashWhitelist(
        address[] memory receptores,
        uint256[] memory limites,
        uint256 timestamp,
        uint256 nonce
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(
            receptores,
            limites,
            timestamp,
            nonce
        ));
    }
    
    function mostrarEncodePacked(
        address[] memory receptores,
        uint256[] memory limites,
        uint256 timestamp,
        uint256 nonce
    ) public pure returns (bytes memory) {
        return abi.encodePacked(
            receptores,
            limites,
            timestamp,
            nonce
        );
    }
}