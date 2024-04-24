// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ISmartAccountERC1155Receiver, IERC1155Receiver} from "./SmartAccountERC1155ReceiverLib.sol";

contract SmartAccountERC1155Receiver is ISmartAccountERC1155Receiver {
    /// @inheritdoc IERC1155Receiver
    function onERC1155Received(address, address, uint256, uint256, bytes memory)
        public
        virtual
        override
        returns (bytes4)
    {
        return this.onERC1155Received.selector;
    }

    /// @inheritdoc IERC1155Receiver
    function onERC1155BatchReceived(address, address, uint256[] memory, uint256[] memory, bytes memory)
        public
        virtual
        override
        returns (bytes4)
    {
        return this.onERC1155BatchReceived.selector;
    }
}
