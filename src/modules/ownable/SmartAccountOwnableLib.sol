// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SmartAccountERC165Lib} from "../erc165/SmartAccountERC165Lib.sol";
import {SmartAccountModulesLib} from "../SmartAccountModulesLib.sol";

import {ISmartAccountOwnable} from "./ISmartAccountOwnable.sol";

library SmartAccountOwnableLib {
    bytes32 constant STORAGE_POSITION = keccak256("ownable.modules.smartaccount.plopmenz");

    struct Storage {
        address owner;
    }

    function getStorage() internal pure returns (Storage storage s) {
        bytes32 position = STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }

    /// @notice Sets the interfaces implemented by this contract to (un)supported.
    function setInterfaces(bool supported) internal {
        SmartAccountERC165Lib.setInterfaceSupport(type(ISmartAccountOwnable).interfaceId, supported);
    }

    /// @notice Installs all functions, interfaces, and performs storage initialization of this module.
    function fullInstall(address module, address initialOwner) internal {
        SmartAccountOwnableLib.setOwner(initialOwner);
        SmartAccountModulesLib.setModule(ISmartAccountOwnable.owner.selector, module);
        setInterfaces(true);
    }

    /// @notice Uninstalls all functions and interfaces of this module.
    function fullUninstall() internal {
        SmartAccountModulesLib.setModule(ISmartAccountOwnable.owner.selector, address(0));
        setInterfaces(false);
    }

    /// @notice Returns the address of the current owner.
    function owner() internal view returns (address) {
        return getStorage().owner;
    }

    /// @notice Reverts if `account` is not the current owner.
    function ensureIsOwner(address account) internal view {
        if (account != owner()) {
            revert ISmartAccountOwnable.NotOwner(account, owner());
        }
    }

    /// @notice Sets the address of the current owner.
    function setOwner(address account) internal {
        getStorage().owner = account;
        emit ISmartAccountOwnable.NewOwner(account);
    }
}
