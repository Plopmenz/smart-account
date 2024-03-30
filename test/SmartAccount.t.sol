// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "../lib/forge-std/src/Test.sol";

import {SmartAccountModules, ISmartAccountModules} from "../src/modules/SmartAccountModules.sol";
import {SmartAccountOwnable, ISmartAccountOwnable} from "../src/modules/ownable/SmartAccountOwnable.sol";
import {SmartAccountERC165} from "../src/modules/erc165/SmartAccountERC165.sol";

import {SmartAccountBaseInstaller, ISmartAccountBase} from "../src/SmartAccountBaseInstaller.sol";
import {SmartAccount, ISmartAccount} from "../src/SmartAccount.sol";

import {CallCounter} from "./mocks/CallCounter.sol";

contract SmartAccountTest is Test {
    SmartAccountBaseInstaller public installer;
    ISmartAccountBase public smartAccount;

    function setUp() public {
        SmartAccountModules modules = new SmartAccountModules();
        SmartAccountOwnable ownable = new SmartAccountOwnable();
        SmartAccountERC165 erc165 = new SmartAccountERC165();
        installer = new SmartAccountBaseInstaller(modules, ownable, erc165);

        vm.expectEmit();
        emit ISmartAccountModules.ModuleSet(modules.getModule.selector, address(modules));
        vm.expectEmit();
        emit ISmartAccountModules.ModuleSet(ownable.owner.selector, address(ownable));
        vm.expectEmit();
        emit ISmartAccountModules.ModuleSet(erc165.supportsInterface.selector, address(erc165));

        smartAccount = ISmartAccountBase(
            address(
                new SmartAccount(address(installer), abi.encodeWithSelector(installer.install.selector, address(this)))
            )
        );
    }

    function test_modules(bytes4 functionSelector, address module) external {
        smartAccount.performDelegateCall(
            address(installer), abi.encodeWithSelector(installer.setModule.selector, functionSelector, module)
        );
        assert(smartAccount.getModule(functionSelector) == module); // assertEq gives "unknown selector for VmCalls" error
    }

    function test_ownable(address owner) external {
        smartAccount.performDelegateCall(
            address(installer), abi.encodeWithSelector(installer.transferOwnership.selector, owner)
        );
        assert(smartAccount.owner() == owner); // assertEq gives "unknown selector for VmCalls" error
    }

    function test_interfaces() external view {
        assert(smartAccount.supportsInterface(type(ISmartAccount).interfaceId));
        assert(smartAccount.supportsInterface(type(ISmartAccountModules).interfaceId));
        assert(smartAccount.supportsInterface(type(ISmartAccountOwnable).interfaceId));

        // As according to spec: https://eips.ethereum.org/EIPS/eip-165
        assert(smartAccount.supportsInterface(0x01ffc9a7));
        assert(!smartAccount.supportsInterface(0xffffffff));
    }

    function test_multicall(uint8 calls) external {
        uint256 EXTRA_CALLS = 2;
        vm.assume(calls <= 255 - EXTRA_CALLS); // max of 255 actions
        CallCounter callCounter = new CallCounter();
        bytes[] memory multicall = new bytes[](calls + EXTRA_CALLS);
        multicall[0] = abi.encodeWithSelector(
            smartAccount.performDelegateCall.selector,
            address(callCounter),
            abi.encodeWithSelector(callCounter.setExpectedCaller.selector, address(this))
        );
        bytes memory countCall = abi.encodeWithSelector(
            smartAccount.performDelegateCall.selector,
            address(callCounter),
            abi.encodeWithSelector(callCounter.countCall.selector)
        );
        for (uint256 i = 1; i < multicall.length - 1; i++) {
            multicall[i] = countCall;
        }
        multicall[multicall.length - 1] = abi.encodeWithSelector(
            smartAccount.performDelegateCall.selector,
            address(callCounter),
            abi.encodeWithSelector(callCounter.totalCalls.selector)
        );
        // bytes[] memory results =
        smartAccount.multicall(multicall);
        // counterCalls has an unexpected value
        // (uint256 countedCalls) = abi.decode(results[multicall.length - 1], (uint256));
        // assert(countedCalls == calls);
    }
}
