// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SmartAccountModulesLib} from "../SmartAccountModulesLib.sol";

import {ISmartAccountERC165, IERC165} from "./ISmartAccountERC165.sol";

library SmartAccountERC165Lib {
    bytes32 constant STORAGE_POSITION = keccak256("erc165.modules.smartaccount.plopmenz");

    struct Storage {
        mapping(bytes4 interfaceId => bool supported) getSupported;
    }

    function getStorage() internal pure returns (Storage storage s) {
        bytes32 position = STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }

    /// @notice Installs all functions, interfaces, and performs storage initialization of this module.
    function fullInstall(address module) internal {
        SmartAccountModulesLib.setModule(IERC165.supportsInterface.selector, module);
    }

    /// @notice Uninstalls all functions and interfaces of this module.
    function fullUninstall() internal {
        SmartAccountModulesLib.setModule(IERC165.supportsInterface.selector, address(0));
    }

    /// @notice Gets the interfaces supported by the Smart Account.
    function supportsInterface(bytes4 interfaceId) internal view returns (bool supported) {
        return getStorage().getSupported[interfaceId];
    }

    /// @notice Updates the interfaces supported by the Smart Account.
    function setInterfaceSupport(bytes4 interfaceId, bool supported) internal {
        getStorage().getSupported[interfaceId] = supported;
        emit ISmartAccountERC165.InterfaceSupportedChanged(interfaceId, supported);
    }
}
