// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISmartAccountOwnable {
    /// @notice Returns the address of the current owner.
    function owner() external view returns (address);

    //// @notice Transfers ownership of the contract to a new account (`newOwner`). Can only be called by the current owner.
    function transferOwnership(address newOwner) external;
}
