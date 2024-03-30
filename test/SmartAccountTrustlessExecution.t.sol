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
    SmartAccountTrustlessExecutionTestInstaller public installer;
    ISmartAccountTrustlessExecutionTest public smartAccount;

    function setUp() public {
        installer = new SmartAccountTrustlessExecutionTestInstaller();

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

    function test_allowedExecutor(address executor) external {
        vm.expectEmit(address(smartAccount));
        emit ISmartAccountTrustlessExecution.ExecutePermissionSet(executor, true);
        smartAccount.performDelegateCall(
            address(installer), abi.encodeWithSelector(installer.setExecutePermission.selector, executor, true)
        );

        vm.startPrank(executor);
        bytes32 callId = bytes32(0);
        ISmartAccountTrustlessExecution.Action[] memory actions = new ISmartAccountTrustlessExecution.Action[](0);
        uint256 allowedFailureMap = 0;
        uint256 failureMap = 0;
        bytes[] memory results = new bytes[](0);

        vm.expectEmit(address(smartAccount));
        emit ISmartAccountTrustlessExecution.Executed(executor, callId, actions, allowedFailureMap, failureMap, results);

        smartAccount.execute(callId, actions, allowedFailureMap);
    }

    function test_interfaces() external view {
        assert(smartAccount.supportsInterface(type(ISmartAccountTrustlessExecution).interfaceId));
    }
}
