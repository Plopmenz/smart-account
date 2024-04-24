// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SmartAccountERC721ReceiverLib, ISmartAccountERC721Receiver} from "./SmartAccountERC721ReceiverLib.sol";

contract SmartAccountERC721ReceiverInstaller {
    ISmartAccountERC721Receiver public immutable SMART_ACCOUNT_ERC721_RECEIVER;

    constructor(ISmartAccountERC721Receiver smartAccountERC721Receiver) {
        SMART_ACCOUNT_ERC721_RECEIVER = smartAccountERC721Receiver;
    }

    /// @notice Installs the trustless execution module into a smart account
    function install() public virtual {
        SmartAccountERC721ReceiverLib.fullInstall(address(SMART_ACCOUNT_ERC721_RECEIVER));
    }

    /// @notice Uninstalls the trustless execution module of a smart account.
    function uninstall() public virtual {
        SmartAccountERC721ReceiverLib.fullUninstall();
    }
}
