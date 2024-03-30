// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ISmartAccount} from "./ISmartAccount.sol";
import {SmartAccountModulesLib, ISmartAccountModules} from "./modules/SmartAccountModulesLib.sol";

import {SmartAccountOwnableLib, ISmartAccountOwnable} from "./modules/ownable/SmartAccountOwnableLib.sol";
import {SmartAccountERC165Lib, IERC165} from "./modules/erc165/SmartAccountERC165Lib.sol";

interface ISetupSmartAccount is ISmartAccount, ISmartAccountModules, ISmartAccountOwnable, IERC165 {}

contract SmartAccountSetup {
    address public immutable SMART_ACCOUNT_MODULES;
    address public immutable SMART_ACCOUNT_OWNABLE;
    address public immutable SMART_ACCOUNT_ERC165;

    constructor(address smartAccountModules, address smartAccountOwnable, address smartAccountERC165) {
        SMART_ACCOUNT_MODULES = smartAccountModules;
        SMART_ACCOUNT_OWNABLE = smartAccountOwnable;
        SMART_ACCOUNT_ERC165 = smartAccountERC165;
    }

    function setup(address owner) external {
        SmartAccountModulesLib.setModule(ISmartAccountModules.setModule.selector, SMART_ACCOUNT_MODULES);
        SmartAccountModulesLib.setModule(ISmartAccountModules.getModule.selector, SMART_ACCOUNT_MODULES);
        SmartAccountModulesLib.setInterfaces(true);

        SmartAccountOwnableLib.setOwner(owner);
        SmartAccountModulesLib.setModule(ISmartAccountOwnable.owner.selector, SMART_ACCOUNT_OWNABLE);
        SmartAccountModulesLib.setModule(ISmartAccountOwnable.transferOwnership.selector, SMART_ACCOUNT_OWNABLE);
        SmartAccountOwnableLib.setInterfaces(true);

        SmartAccountModulesLib.setModule(IERC165.supportsInterface.selector, SMART_ACCOUNT_ERC165);
        SmartAccountERC165Lib.setInterfaceSupport(type(ISmartAccount).interfaceId, true);
    }
}
