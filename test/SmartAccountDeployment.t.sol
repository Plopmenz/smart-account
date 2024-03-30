// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";

import {SmartAccountModules, ISmartAccountModules} from "../src/modules/SmartAccountModules.sol";
import {SmartAccountOwnable, ISmartAccountOwnable} from "../src/modules/ownable/SmartAccountOwnable.sol";
import {SmartAccountERC165, IERC165} from "../src/modules/erc165/SmartAccountERC165.sol";

import {SmartAccountSetup} from "../src/SmartAccountSetup.sol";
import {SmartAccount} from "../src/SmartAccount.sol";

contract SmartAccountTest is Test {
    SmartAccountSetup public smartAcountSetup;

    function setUp() public {
        SmartAccountModules modules = new SmartAccountModules();
        SmartAccountOwnable ownable = new SmartAccountOwnable();
        SmartAccountERC165 erc165 = new SmartAccountERC165();
        smartAcountSetup = new SmartAccountSetup(address(modules), address(ownable), address(erc165));
    }

    // For gas cost snapshots
    function test_deploy() external {
        new SmartAccount(
            address(smartAcountSetup), abi.encodeWithSelector(smartAcountSetup.setup.selector, address(this))
        );
    }
}
