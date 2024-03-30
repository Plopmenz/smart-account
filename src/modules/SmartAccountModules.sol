// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SmartAccountOwnableLib} from "./ownable/SmartAccountOwnableLib.sol";

import {SmartAccountModulesLib, ISmartAccountModules} from "./SmartAccountModulesLib.sol";

contract SmartAccountModules is ISmartAccountModules {
    /// @inheritdoc ISmartAccountModules
    function getModule(bytes4 functionSelector) external view returns (address module) {
        return SmartAccountModulesLib.getModule(functionSelector);
    }

    /// @inheritdoc ISmartAccountModules
    function setModule(bytes4 functionSelector, address module) external {
        SmartAccountOwnableLib.ensureIsOwner(msg.sender);
        SmartAccountModulesLib.setModule(functionSelector, module);
    }
}
