// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SmartAccountOwnableLib} from "../ownable/SmartAccountOwnableLib.sol";
import {
    SmartAccountTrustlessExecutionLib, ISmartAccountTrustlessExecution
} from "./SmartAccountTrustlessExecutionLib.sol";

contract SmartAccountTrustlessExecutionInstaller {
    ISmartAccountTrustlessExecution public immutable SMART_ACCOUNT_TRUSTLESS_EXECUTION;

    constructor(ISmartAccountTrustlessExecution smartAccountTrustlessExecution) {
        SMART_ACCOUNT_TRUSTLESS_EXECUTION = smartAccountTrustlessExecution;
    }

    /// @notice Installs the trustless execution module into a smart account
    function install() public virtual {
        SmartAccountTrustlessExecutionLib.fullInstall(address(SMART_ACCOUNT_TRUSTLESS_EXECUTION));
    }

    /// @notice Uninstalls the trustless execution module of a smart account.
    function uninstall() public virtual {
        SmartAccountTrustlessExecutionLib.fullUninstall();
    }

    /// @notice Sets if `account` is allowed to execute actions for this smart account.
    function setExecutePermission(address account, bool allowed) external {
        SmartAccountOwnableLib.ensureIsOwner(msg.sender);
        SmartAccountTrustlessExecutionLib.setExecutePermission(account, allowed);
    }
}
