//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import {IAMBBridge} from "./IAMBBridge.sol";
import {IAMBReceiver} from "./IAMBReceiver.sol";

contract AMBSender {
    event Bridged(bytes32 messageId);

    error OnlyOwner();

    address internal _owner;
    address internal _bridge;
    address internal _receiver;
    uint256 internal _gasLimit;

    modifier onlyOwner() {
        if (msg.sender != _owner) {
            revert OnlyOwner();
        }
        _;
    }

    constructor(
        address bridge,
        address receiver,
        uint256 gasLimit
    ) {
        _owner = msg.sender;
        _bridge = bridge;
        _receiver = receiver;
        _gasLimit = gasLimit;
    }

    function setValueThroughBridge(uint256 value) external {
        bytes memory data = abi.encodeWithSelector(
            IAMBReceiver(address(0)).setValue.selector,
            _receiver,
            value
        );
        bytes32 messageId = IAMBBridge(_bridge).requireToPassMessage(
            _receiver,
            data,
            _gasLimit
        );
        emit Bridged(messageId);
    }

    function setGasLimit(uint256 gasLimit) external onlyOwner {
        _gasLimit = gasLimit;
    }

    function setReceiver(address newReceiver) external onlyOwner {
        _receiver = newReceiver;
    }
}
