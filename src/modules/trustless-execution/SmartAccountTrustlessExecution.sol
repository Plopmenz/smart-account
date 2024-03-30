// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {
    SmartAccountTrustlessExecutionLib, ISmartAccountTrustlessExecution
} from "./SmartAccountTrustlessExecutionLib.sol";

contract SmartAccountTrustlessExecution is ISmartAccountTrustlessExecution {
    /// @inheritdoc ISmartAccountTrustlessExecution
    function execute(bytes32 _callId, Action[] calldata _actions, uint256 _allowFailureMap)
        external
        override
        returns (bytes[] memory execResults, uint256 failureMap)
    {
        return SmartAccountTrustlessExecutionLib.execute(_callId, _actions, _allowFailureMap);
    }
}
