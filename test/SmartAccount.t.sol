// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";

import {SmartAccountModules, ISmartAccountModules} from "../src/modules/SmartAccountModules.sol";
import {SmartAccountOwnable, ISmartAccountOwnable} from "../src/modules/ownable/SmartAccountOwnable.sol";
import {SmartAccountERC165} from "../src/modules/erc165/SmartAccountERC165.sol";

import {SmartAccountSetup, ISetupSmartAccount} from "../src/SmartAccountSetup.sol";
import {SmartAccount, ISmartAccount} from "../src/SmartAccount.sol";

import {CallCounter} from "./mocks/CallCounter.sol";

contract SmartAccountTest is Test {
    ISetupSmartAccount public smartAccount;

    function setUp() public {
        SmartAccountModules modules = new SmartAccountModules();
        SmartAccountOwnable ownable = new SmartAccountOwnable();
        SmartAccountERC165 erc165 = new SmartAccountERC165();
        SmartAccountSetup setup = new SmartAccountSetup(address(modules), address(ownable), address(erc165));
        smartAccount = ISetupSmartAccount(
            address(new SmartAccount(address(setup), abi.encodeWithSelector(setup.setup.selector, address(this))))
        );
    }

    function test_modules(bytes4 functionSelector, address module) external {
        smartAccount.setModule(functionSelector, module);
        assertEq(smartAccount.getModule(functionSelector), module);
    }

    function test_ownable(address owner) external {
        smartAccount.transferOwnership(owner);
        assertEq(smartAccount.owner(), owner);
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
        vm.assume(calls < 252); // with 4 extra that gives max of 255 actions
        address callCounter = address(new CallCounter());
        bytes[] memory multicall = new bytes[](calls + 4);
        multicall[0] =
            abi.encodeWithSelector(smartAccount.setModule.selector, CallCounter.setExpectedCaller.selector, callCounter);
        multicall[1] =
            abi.encodeWithSelector(smartAccount.setModule.selector, CallCounter.countCall.selector, callCounter);
        multicall[2] =
            abi.encodeWithSelector(smartAccount.setModule.selector, CallCounter.totalCalls.selector, callCounter);
        multicall[3] = abi.encodeWithSelector(CallCounter.setExpectedCaller.selector, address(this));
        bytes memory countCall = abi.encodeWithSelector(CallCounter.countCall.selector);
        for (uint256 i = 4; i < multicall.length; i++) {
            multicall[i] = countCall;
        }
        smartAccount.multicall(multicall);
        assertEq(CallCounter(address(smartAccount)).totalCalls(), calls);
    }
}
