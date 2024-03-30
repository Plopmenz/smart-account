// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SmartAccountModulesLib} from "../../src/modules/SmartAccountModulesLib.sol";

contract CallCounter {
    error NotExpectedCaller();

    bytes32 constant STORAGE_POSITION = keccak256("callcounter.mocks.modules.smartaccount.plopmenz");

    struct Storage {
        address expectedCaller;
        uint256 called;
    }

    function getStorage() internal pure returns (Storage storage s) {
        bytes32 position = STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }

    function totalCalls() external view returns (uint256 called) {
        return getStorage().called;
    }

    function setExpectedCaller(address caller) external {
        getStorage().expectedCaller = caller;
    }

    function countCall() external {
        Storage storage s = getStorage();
        if (msg.sender != s.expectedCaller) {
            revert NotExpectedCaller();
        }
        ++s.called;
    }
}
