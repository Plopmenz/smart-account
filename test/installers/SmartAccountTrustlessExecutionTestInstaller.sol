// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SmartAccountModules} from "../../src/modules/SmartAccountModules.sol";
import {SmartAccountOwnable} from "../../src/modules/ownable/SmartAccountOwnable.sol";
import {SmartAccountERC165} from "../../src/modules/erc165/SmartAccountERC165.sol";
import {SmartAccountTrustlessExecution} from "../../src/modules/trustless-execution/SmartAccountTrustlessExecution.sol";

import {SmartAccountBaseInstaller, ISmartAccountBase} from "../../src/SmartAccountBaseInstaller.sol";
import {
    SmartAccountTrustlessExecutionInstaller,
    ISmartAccountTrustlessExecution
} from "../../src/modules/trustless-execution/SmartAccountTrustlessExecutionInstaller.sol";

interface ISmartAccountTrustlessExecutionTest is ISmartAccountBase, ISmartAccountTrustlessExecution {}

contract SmartAccountTrustlessExecutionTestInstaller is
    SmartAccountBaseInstaller,
    SmartAccountTrustlessExecutionInstaller
{
    error IncorrectInstaller();

    constructor()
        SmartAccountBaseInstaller(new SmartAccountModules(), new SmartAccountOwnable(), new SmartAccountERC165())
        SmartAccountTrustlessExecutionInstaller(new SmartAccountTrustlessExecution())
    {}

    /// @inheritdoc SmartAccountBaseInstaller
    function install(address owner) public override {
        super.install(owner);
        super.install();
    }

    /// @inheritdoc SmartAccountTrustlessExecutionInstaller
    function install() public pure override {
        revert IncorrectInstaller();
    }

    function uninstall() public override(SmartAccountBaseInstaller, SmartAccountTrustlessExecutionInstaller) {
        SmartAccountBaseInstaller.uninstall();
        SmartAccountTrustlessExecutionInstaller.uninstall();
    }
}
