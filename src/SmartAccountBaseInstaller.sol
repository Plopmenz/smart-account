// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ISmartAccount} from "./ISmartAccount.sol";
import {SmartAccountModulesLib, ISmartAccountModules} from "./modules/SmartAccountModulesLib.sol";

import {SmartAccountOwnableLib, ISmartAccountOwnable} from "./modules/ownable/SmartAccountOwnableLib.sol";
import {SmartAccountERC165Lib, ISmartAccountERC165} from "./modules/erc165/SmartAccountERC165Lib.sol";

interface ISmartAccountBase is ISmartAccount, ISmartAccountModules, ISmartAccountOwnable, ISmartAccountERC165 {}

contract SmartAccountBaseInstaller {
    ISmartAccountModules public immutable SMART_ACCOUNT_MODULES;
    ISmartAccountOwnable public immutable SMART_ACCOUNT_OWNABLE;
    ISmartAccountERC165 public immutable SMART_ACCOUNT_ERC165;

    constructor(
        ISmartAccountModules smartAccountModules,
        ISmartAccountOwnable smartAccountOwnable,
        ISmartAccountERC165 smartAccountERC165
    ) {
        SMART_ACCOUNT_MODULES = smartAccountModules;
        SMART_ACCOUNT_OWNABLE = smartAccountOwnable;
        SMART_ACCOUNT_ERC165 = smartAccountERC165;
    }

    /// @notice Installs the base modules into a smart account.
    /// @param owner The initial owner of the smart account.
    function install(address owner) public virtual {
        SmartAccountERC165Lib.setInterfaceSupport(type(ISmartAccount).interfaceId, true);
        SmartAccountModulesLib.fullInstall(address(SMART_ACCOUNT_MODULES));
        SmartAccountOwnableLib.fullInstall(address(SMART_ACCOUNT_OWNABLE), owner);
        SmartAccountERC165Lib.fullInstall(address(SMART_ACCOUNT_ERC165));
    }

    /// @notice Uninstalls the base modules of a smart account.
    /// @dev This will not remove any storage (except interfaces). This means that owner stays active for the base smart account functionality. Any uninstalled modules will also stay active (even though the module manager is uninstalled).
    function uninstall() public virtual {
        SmartAccountModulesLib.fullUninstall();
        SmartAccountOwnableLib.fullUninstall();
        SmartAccountERC165Lib.fullUninstall();
    }

    /// @notice Set the currently registered module for function.
    /// @param functionSelector Function of the module to register.
    /// @param module Address of the module to forward the call to.
    /// @dev Set to zero address to remove.
    /// @dev Will override any existing module registered for this function without warning.
    /// @dev In case of an uninstall of a module containing this function, the function will be removed, no matter if the uninstalled module is the current module for this function.
    function setModule(bytes4 functionSelector, address module) external {
        SmartAccountOwnableLib.ensureIsOwner(msg.sender);
        SmartAccountModulesLib.setModule(functionSelector, module);
    }

    //// @notice Transfers ownership of the contract to a new account (`newOwner`). Can only be called by the current owner.
    function transferOwnership(address newOwner) external {
        SmartAccountOwnableLib.ensureIsOwner(msg.sender);
        SmartAccountOwnableLib.setOwner(newOwner);
    }
}
