// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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

    function setExpectedCaller(address caller) external {
        getStorage().expectedCaller = caller;
    }

    function totalCalls() external view returns (uint256 called) {
        return getStorage().called;
    }

    function countCall() external {
        Storage storage s = getStorage();
        if (msg.sender != s.expectedCaller) {
            revert NotExpectedCaller();
        }
        ++s.called;
    }
}
