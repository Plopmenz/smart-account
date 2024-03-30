// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISmartAccountTrustlessExecution {
    /// @notice The caller account is not authorized to perform an operation.
    error NoExecutePermission(address account);

    /// @notice Thrown if the action array length is larger than `MAX_ACTIONS`.
    error TooManyActions();

    /// @notice Thrown if action execution has failed.
    /// @param index The index of the action in the action array that failed.
    error ActionFailed(uint256 index);

    /// @notice Thrown if an action has insufficent gas left.
    error InsufficientGas();

    /// @notice A (new) account has become the owner of this contract.
    event ExecutePermissionSet(address account, bool allowed);

    /// @notice Emitted when an execution is performed.
    /// @param actor The address of the caller.
    /// @param callId The ID of the call.
    /// @param actions The array of actions executed.
    /// @param allowFailureMap The allow failure map encoding which actions are allowed to fail.
    /// @param failureMap The failure map encoding which actions have failed.
    /// @param execResults The array with the results of the executed actions.
    /// @dev The value of `callId` is defined by the component/contract calling the execute function. A `Plugin` implementation can use it, for example, as a nonce.
    event Executed(
        address indexed actor,
        bytes32 callId,
        Action[] actions,
        uint256 allowFailureMap,
        uint256 failureMap,
        bytes[] execResults
    );

    /// @notice The action struct to be consumed by the DAO's `execute` function resulting in an external call.
    /// @param to The address to call.
    /// @param value The native token value to be sent with the call.
    /// @param data The bytes-encoded function selector and calldata for the call.
    struct Action {
        address to;
        uint256 value;
        bytes data;
    }

    /// @notice Executes a list of actions. If a zero allow-failure map is provided, a failing action reverts the entire execution. If a non-zero allow-failure map is provided, allowed actions can fail without the entire call being reverted.
    /// @param _callId The ID of the call. The definition of the value of `callId` is up to the calling contract and can be used, e.g., as a nonce.
    /// @param _actions The array of actions.
    /// @param _allowFailureMap A bitmap allowing execution to succeed, even if individual actions might revert. If the bit at index `i` is 1, the execution succeeds even if the `i`th action reverts. A failure map value of 0 requires every action to not revert.
    /// @return execResults The array of results obtained from the executed actions in `bytes`.
    /// @return failureMap The resulting failure map containing the actions have actually failed.
    function execute(bytes32 _callId, Action[] memory _actions, uint256 _allowFailureMap)
        external
        returns (bytes[] memory execResults, uint256 failureMap);
}
