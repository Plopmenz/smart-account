// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SmartAccountERC165Lib} from "../erc165/SmartAccountERC165Lib.sol";
import {SmartAccountModulesLib} from "../SmartAccountModulesLib.sol";

import {ISmartAccountTrustlessExecution} from "./ISmartAccountTrustlessExecution.sol";

uint256 constant MAX_ACTIONS = 256;

library SmartAccountTrustlessExecutionLib {
    bytes32 constant STORAGE_POSITION = keccak256("execution.trustless.modules.smartaccount.plopmenz");

    struct Storage {
        mapping(address executor => bool allowed) executePermission;
    }

    function getStorage() internal pure returns (Storage storage s) {
        bytes32 position = STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }

    /// @notice Sets the interfaces implemented by this contract to (un)supported.
    function setInterfaces(bool supported) internal {
        SmartAccountERC165Lib.setInterfaceSupport(type(ISmartAccountTrustlessExecution).interfaceId, supported);
    }

    /// @notice Installs all functions, interfaces, and performs storage initialization of this module.
    function fullInstall(address module) internal {
        SmartAccountModulesLib.setModule(ISmartAccountTrustlessExecution.execute.selector, module);
        setInterfaces(true);
    }

    /// @notice Uninstalls all functions and interfaces of this module.
    function fullUninstall() internal {
        SmartAccountModulesLib.setModule(ISmartAccountTrustlessExecution.execute.selector, address(0));
        setInterfaces(false);
    }

    /// @notice Reverts if `account` is not allowed to execute actions for this smart account.
    function ensureHasExecutePermission(address account) internal view {
        if (!getStorage().executePermission[account]) {
            revert ISmartAccountTrustlessExecution.NoExecutePermission(account);
        }
    }

    /// @notice Sets if `account` is allowed to execute actions for this smart account.
    function setExecutePermission(address account, bool allowed) internal {
        getStorage().executePermission[account] = allowed;
        emit ISmartAccountTrustlessExecution.ExecutePermissionSet(account, allowed);
    }

    /// Source: https://github.com/aragon/osx/blob/develop/packages/contracts/src/core/dao/DAO.sol
    /// @notice Executes a list of actions. If a zero allow-failure map is provided, a failing action reverts the entire execution. If a non-zero allow-failure map is provided, allowed actions can fail without the entire call being reverted.
    /// @param _callId The ID of the call. The definition of the value of `callId` is up to the calling contract and can be used, e.g., as a nonce.
    /// @param _actions The array of actions.
    /// @param _allowFailureMap A bitmap allowing execution to succeed, even if individual actions might revert. If the bit at index `i` is 1, the execution succeeds even if the `i`th action reverts. A failure map value of 0 requires every action to not revert.
    /// @return execResults The array of results obtained from the executed actions in `bytes`.
    /// @return failureMap The resulting failure map containing the actions have actually failed.
    function execute(
        bytes32 _callId,
        ISmartAccountTrustlessExecution.Action[] calldata _actions,
        uint256 _allowFailureMap
    ) internal returns (bytes[] memory execResults, uint256 failureMap) {
        ensureHasExecutePermission(msg.sender);

        // Check that the action array length is within bounds.
        if (_actions.length > MAX_ACTIONS) {
            revert ISmartAccountTrustlessExecution.TooManyActions();
        }

        execResults = new bytes[](_actions.length);

        uint256 gasBefore;
        uint256 gasAfter;

        for (uint256 i = 0; i < _actions.length;) {
            gasBefore = gasleft();

            (bool success, bytes memory result) = _actions[i].to.call{value: _actions[i].value}(_actions[i].data);
            gasAfter = gasleft();

            // Check if failure is allowed
            if (!hasBit(_allowFailureMap, uint8(i))) {
                // Check if the call failed.
                if (!success) {
                    revert ISmartAccountTrustlessExecution.ActionFailed(i);
                }
            } else {
                // Check if the call failed.
                if (!success) {
                    // Make sure that the action call did not fail because 63/64 of `gasleft()` was insufficient to execute the external call `.to.call` (see [ERC-150](https://eips.ethereum.org/EIPS/eip-150)).
                    // In specific scenarios, i.e. proposal execution where the last action in the action array is allowed to fail, the account calling `execute` could force-fail this action by setting a gas limit
                    // where 63/64 is insufficient causing the `.to.call` to fail, but where the remaining 1/64 gas are sufficient to successfully finish the `execute` call.
                    if (gasAfter < gasBefore / 64) {
                        revert ISmartAccountTrustlessExecution.InsufficientGas();
                    }

                    // Store that this action failed.
                    failureMap = flipBit(failureMap, uint8(i));
                }
            }

            execResults[i] = result;

            unchecked {
                ++i;
            }
        }

        emit ISmartAccountTrustlessExecution.Executed({
            actor: msg.sender,
            callId: _callId,
            actions: _actions,
            allowFailureMap: _allowFailureMap,
            failureMap: failureMap,
            execResults: execResults
        });
    }

    /// Source: https://github.com/aragon/osx-commons/blob/develop/contracts/src/utils/math/BitMap.sol
    /// @param bitmap The `uint256` representation of bits.
    /// @param index The index number to check whether 1 or 0 is set.
    /// @return Returns `true` if the bit is set at `index` on `bitmap`.
    function hasBit(uint256 bitmap, uint8 index) internal pure returns (bool) {
        uint256 bitValue = bitmap & (1 << index);
        return bitValue > 0;
    }

    /// Source: https://github.com/aragon/osx-commons/blob/develop/contracts/src/utils/math/BitMap.sol
    /// @param bitmap The `uint256` representation of bits.
    /// @param index The index number to set the bit.
    /// @return Returns a new number in which the bit is set at `index`.
    function flipBit(uint256 bitmap, uint8 index) internal pure returns (uint256) {
        return bitmap ^ (1 << index);
    }
}
