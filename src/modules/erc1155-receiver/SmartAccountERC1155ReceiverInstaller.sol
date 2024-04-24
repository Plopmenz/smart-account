// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SmartAccountERC1155ReceiverLib, ISmartAccountERC1155Receiver} from "./SmartAccountERC1155ReceiverLib.sol";

contract SmartAccountERC1155ReceiverInstaller {
    ISmartAccountERC1155Receiver public immutable SMART_ACCOUNT_ERC1155_RECEIVER;

    constructor(ISmartAccountERC1155Receiver smartAccountERC1155Receiver) {
        SMART_ACCOUNT_ERC1155_RECEIVER = smartAccountERC1155Receiver;
    }

    /// @notice Installs the trustless execution module into a smart account
    function install() public virtual {
        SmartAccountERC1155ReceiverLib.fullInstall(address(SMART_ACCOUNT_ERC1155_RECEIVER));
    }

    /// @notice Uninstalls the trustless execution module of a smart account.
    function uninstall() public virtual {
        SmartAccountERC1155ReceiverLib.fullUninstall();
    }
}
