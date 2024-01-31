// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract AdminAccount is Ownable {
    constructor(address admin) Ownable(admin) {}

    function execute(address to, uint256 value, bytes calldata data)
        external
        onlyOwner
        returns (bool success, bytes memory returnValue)
    {
        (success, returnValue) = to.call{value: value}(data);
    }

    function performDelegateCall(address to, bytes calldata data)
        external
        onlyOwner
        returns (bool success, bytes memory returnValue)
    {
        (success, returnValue) = to.delegatecall(data);
    }
}
