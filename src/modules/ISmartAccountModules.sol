// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISmartAccountModules {
    /// @notice When no function exists for function called
    error FunctionNotFound(bytes4 functionSelector);

    /// @notice Module is added/updated/removed.
    event ModuleSet(bytes4 functionSelector, address module);

    /// @notice Set the currently registered module for function.
    /// @dev Zero address means no module is registered.
    function getModule(bytes4 functionSelector) external view returns (address module);
}
