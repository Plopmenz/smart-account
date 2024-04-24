// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SmartAccountERC165Lib} from "../erc165/SmartAccountERC165Lib.sol";
import {SmartAccountModulesLib} from "../SmartAccountModulesLib.sol";

import {ISmartAccountERC721Receiver, IERC721Receiver} from "./ISmartAccountERC721Receiver.sol";

library SmartAccountERC721ReceiverLib {
    /// @notice Sets the interfaces implemented by this contract to (un)supported.
    function setInterfaces(bool supported) internal {
        SmartAccountERC165Lib.setInterfaceSupport(type(IERC721Receiver).interfaceId, supported);
    }

    /// @notice Installs all functions, interfaces, and performs storage initialization of this module.
    function fullInstall(address module) internal {
        SmartAccountModulesLib.setModule(IERC721Receiver.onERC721Received.selector, module);
        setInterfaces(true);
    }

    /// @notice Uninstalls all functions and interfaces of this module.
    function fullUninstall() internal {
        SmartAccountModulesLib.setModule(IERC721Receiver.onERC721Received.selector, address(0));
        setInterfaces(false);
    }
}
