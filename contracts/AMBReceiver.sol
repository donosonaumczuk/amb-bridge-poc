//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import {IAMBBridge} from "./IAMBBridge.sol";

contract AMBReceiver {
    error OnlyBridge();
    error OnlyOwner();
    error OnlySender();
    error UnacceptedChainId();

    address internal _owner;
    address internal _bridge;
    address internal _sender;
    mapping(uint256 => bool) internal _acceptedSourceChainIds;

    uint256 public value;

    event ValueSet(uint256 indexed value);

    modifier onlyOwner() {
        if (msg.sender != _owner) {
            revert OnlyOwner();
        }
        _;
    }

    modifier onlyBridge() {
        if (msg.sender != _bridge) {
            revert OnlyBridge();
        }
        _;
    }

    constructor(
        address bridge,
        address sender,
        uint256 chainId
    ) {
        _owner = msg.sender;
        _bridge = bridge;
        _sender = sender;
        _acceptedSourceChainIds[chainId] = true;
    }

    function setValue(uint256 newValue) external onlyBridge {
        if (
            !_acceptedSourceChainIds[IAMBBridge(_bridge).messageSourceChainId()]
        ) {
            revert UnacceptedChainId();
        }
        if (IAMBBridge(_bridge).messageSender() != _sender) {
            revert OnlySender();
        }
        emit ValueSet(newValue);
    }

    function setOwner(address newOwner) external onlyOwner {
        _owner = newOwner;
    }

    function setSender(address newSender) external onlyOwner {
        _sender = newSender;
    }

    function setChainId(uint256 chainId, bool accepted) external onlyOwner {
        _acceptedSourceChainIds[chainId] = accepted;
    }
}
