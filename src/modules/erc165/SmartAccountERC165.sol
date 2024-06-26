// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC165} from "../../../lib/openzeppelin-contracts/contracts/utils/introspection/ERC165.sol";

import {SmartAccountERC165Lib, ISmartAccountERC165, IERC165} from "./SmartAccountERC165Lib.sol";

contract SmartAccountERC165 is ERC165, ISmartAccountERC165 {
    /// @inheritdoc ERC165
    function supportsInterface(bytes4 interfaceId) public view override(ERC165, IERC165) returns (bool) {
        return SmartAccountERC165Lib.supportsInterface(interfaceId) || super.supportsInterface(interfaceId);
    }
}
