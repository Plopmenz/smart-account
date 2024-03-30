// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISmartAccountModules {
    /// @notice Set the currently registered module for function.
    /// @dev Set to zero address to remove.
    function getModule(bytes4 functionSelector) external view returns (address module);

    /// @notice Set the currently registered module for function.
    /// @dev Set to zero address to remove.
    function setModule(bytes4 functionSelector, address module) external;
}
