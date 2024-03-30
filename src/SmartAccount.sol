// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Address} from "../lib/openzeppelin-contracts/contracts/utils/Multicall.sol";

import {SmartAccountModulesLib} from "./modules/SmartAccountModulesLib.sol";
import {SmartAccountOwnableLib} from "./modules/ownable/SmartAccountOwnableLib.sol";
import {ISmartAccount} from "./ISmartAccount.sol";

contract SmartAccount is ISmartAccount {
    constructor(address installer, bytes memory installData) {
        Address.functionDelegateCall(installer, installData);
    }

    /// @inheritdoc ISmartAccount
    function performCall(address to, uint256 value, bytes calldata data) external returns (bytes memory returnValue) {
        SmartAccountOwnableLib.ensureIsOwner(msg.sender);
        return Address.functionCallWithValue(to, data, value);
    }

    /// @inheritdoc ISmartAccount
    function performDelegateCall(address to, bytes calldata data) external returns (bytes memory returnValue) {
        SmartAccountOwnableLib.ensureIsOwner(msg.sender);
        return Address.functionDelegateCall(to, data);
    }

    /// @inheritdoc ISmartAccount
    function multicall(bytes[] calldata data) external returns (bytes[] memory results) {
        results = new bytes[](data.length);
        for (uint256 i; i < data.length;) {
            results[i] = Address.functionDelegateCall(address(this), data[i]);
            unchecked {
                ++i;
            }
        }
        return results;
    }

    /// @notice Calls smart account module if any is registered for this function call.
    fallback() external payable {
        SmartAccountModulesLib.callModule();
    }

    receive() external payable {}
}
