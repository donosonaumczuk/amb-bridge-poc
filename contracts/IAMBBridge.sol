//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IAMBBridge {
    function messageSender() external view returns (address);

    function messageSourceChainId() external view returns (uint256);

    function requireToPassMessage(
        address contractAddress,
        bytes calldata data,
        uint256 gas
    ) external returns (bytes32);

    function destinationChainId() external view returns (uint256);
}
