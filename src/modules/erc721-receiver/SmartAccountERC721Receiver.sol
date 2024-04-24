// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ISmartAccountERC721Receiver, IERC721Receiver} from "./SmartAccountERC721ReceiverLib.sol";

contract SmartAccountERC721Receiver is ISmartAccountERC721Receiver {
    /// @inheritdoc IERC721Receiver
    function onERC721Received(address, address, uint256, bytes memory) public virtual returns (bytes4) {
        return this.onERC721Received.selector;
    }
}
