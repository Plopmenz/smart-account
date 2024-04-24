// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SmartAccountERC165Lib} from "../erc165/SmartAccountERC165Lib.sol";
import {SmartAccountModulesLib} from "../SmartAccountModulesLib.sol";

import {ISmartAccountERC1155Receiver, IERC1155Receiver} from "./ISmartAccountERC1155Receiver.sol";

library SmartAccountERC1155ReceiverLib {
    /// @notice Sets the interfaces implemented by this contract to (un)supported.
    function setInterfaces(bool supported) internal {
        SmartAccountERC165Lib.setInterfaceSupport(type(IERC1155Receiver).interfaceId, supported);
    }

    /// @notice Installs all functions, interfaces, and performs storage initialization of this module.
    function fullInstall(address module) internal {
        SmartAccountModulesLib.setModule(IERC1155Receiver.onERC1155Received.selector, module);
        SmartAccountModulesLib.setModule(IERC1155Receiver.onERC1155BatchReceived.selector, module);
        setInterfaces(true);
    }

    /// @notice Uninstalls all functions and interfaces of this module.
    function fullUninstall() internal {
        SmartAccountModulesLib.setModule(IERC1155Receiver.onERC1155Received.selector, address(0));
        SmartAccountModulesLib.setModule(IERC1155Receiver.onERC1155BatchReceived.selector, address(0));
        setInterfaces(false);
    }
}
