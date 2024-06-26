// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISmartAccount {
    /// @notice Executes an arbitrary blockchain call.
    function performCall(address to, uint256 value, bytes calldata data) external returns (bytes memory returnValue);

    /// @notice Executes an arbitrary blockchain call with delegateCall. This allows advanced code execution inside the account itself.
    function performDelegateCall(address to, bytes calldata data) external returns (bytes memory returnValue);

    /// @notice Receives and executes a batch of function calls on this contract.
    function multicall(bytes[] calldata data) external returns (bytes[] memory results);
}
