// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {Multicall} from "../lib/openzeppelin-contracts/contracts/utils/Multicall.sol";

import {ISmartAccount} from "./ISmartAccount.sol";

contract AdminAccount is Ownable, Multicall, ISmartAccount {
    constructor(address admin) Ownable(admin) {}

    /// @inheritdoc ISmartAccount
    function performCall(address to, uint256 value, bytes calldata data)
        external
        onlyOwner
        returns (bool success, bytes memory returnValue)
    {
        (success, returnValue) = to.call{value: value}(data);
    }

    /// @inheritdoc ISmartAccount
    function performDelegateCall(address to, bytes calldata data)
        external
        onlyOwner
        returns (bool success, bytes memory returnValue)
    {
        (success, returnValue) = to.delegatecall(data);
    }
}
