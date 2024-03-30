// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SmartAccountOwnableLib, ISmartAccountOwnable} from "./SmartAccountOwnableLib.sol";

contract SmartAccountOwnable is ISmartAccountOwnable {
    /// @inheritdoc ISmartAccountOwnable
    function owner() external view returns (address) {
        return SmartAccountOwnableLib.owner();
    }

    /// @inheritdoc ISmartAccountOwnable
    function transferOwnership(address newOwner) external {
        SmartAccountOwnableLib.ensureIsOwner(msg.sender);
        SmartAccountOwnableLib.setOwner(newOwner);
    }
}
