// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "../lib/forge-std/src/Test.sol";

import {
    SmartAccountTrustlessExecutionTestInstaller,
    ISmartAccountTrustlessExecutionTest,
    ISmartAccountTrustlessExecution
} from "./installers/SmartAccountTrustlessExecutionTestInstaller.sol";
import {ISmartAccountModules} from "../src/modules/ISmartAccountModules.sol";

import {SmartAccount, ISmartAccount} from "../src/SmartAccount.sol";

import {CallCounter} from "./mocks/CallCounter.sol";

contract SmartAccountTrustlessExecutionTest is Test {
    ISmartAccountTrustlessExecutionTest public smartAccount;

    function setUp() public {
        SmartAccountTrustlessExecutionTestInstaller installer = new SmartAccountTrustlessExecutionTestInstaller();

        vm.expectEmit();
        emit ISmartAccountModules.ModuleSet(
            ISmartAccountTrustlessExecution.execute.selector, address(installer.SMART_ACCOUNT_TRUSTLESS_EXECUTION())
        );

        smartAccount = ISmartAccountTrustlessExecutionTest(
            address(new SmartAccount(address(installer), abi.encodeWithSignature("install(address)", address(this))))
        );
    }

    function test_randomExecutor(address executor) external {
        vm.startPrank(executor);
        vm.expectRevert(abi.encodeWithSelector(ISmartAccountTrustlessExecution.NoExecutePermission.selector, executor));
        ISmartAccountTrustlessExecution.Action[] memory actions = new ISmartAccountTrustlessExecution.Action[](0);
        smartAccount.execute(bytes32(0), actions, 0);
    }

    function test_interfaces() external view {
        assert(smartAccount.supportsInterface(type(ISmartAccountTrustlessExecution).interfaceId));
    }
}
