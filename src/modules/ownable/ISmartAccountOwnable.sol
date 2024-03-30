// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISmartAccountOwnable {
    /// @notice The caller account is not authorized to perform an operation.
    error NotOwner(address account, address owner);

    /// @notice A (new) account has become the owner of this contract.
    event NewOwner(address account);

    /// @notice Returns the address of the current owner.
    function owner() external view returns (address);
}
