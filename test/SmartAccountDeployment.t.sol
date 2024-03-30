// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "../lib/forge-std/src/Test.sol";

import {SmartAccountModules, ISmartAccountModules} from "../src/modules/SmartAccountModules.sol";
import {SmartAccountOwnable, ISmartAccountOwnable} from "../src/modules/ownable/SmartAccountOwnable.sol";
import {SmartAccountERC165, ISmartAccountERC165} from "../src/modules/erc165/SmartAccountERC165.sol";

import {SmartAccountBaseInstaller} from "../src/SmartAccountBaseInstaller.sol";
import {SmartAccount} from "../src/SmartAccount.sol";

contract SmartAccountTest is Test {
    SmartAccountBaseInstaller public smartAccountInstaller;

    function setUp() public {
        SmartAccountModules modules = new SmartAccountModules();
        SmartAccountOwnable ownable = new SmartAccountOwnable();
        SmartAccountERC165 erc165 = new SmartAccountERC165();
        smartAccountInstaller = new SmartAccountBaseInstaller(modules, ownable, erc165);
    }

    // For gas cost snapshots
    function test_deploy() external {
        new SmartAccount(
            address(smartAccountInstaller),
            abi.encodeWithSelector(smartAccountInstaller.install.selector, address(this))
        );
    }
}
