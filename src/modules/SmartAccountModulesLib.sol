// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SmartAccountERC165Lib} from "./erc165/SmartAccountERC165Lib.sol";

import {ISmartAccountModules} from "./ISmartAccountModules.sol";

// Inspired by ERC-2535
library SmartAccountModulesLib {
    /// @notice When no function exists for function called
    error FunctionNotFound(bytes4 functionSelector);

    /// @notice Module is added/updated/removed.
    event ModuleSet(bytes4 functionSelector, address module);

    bytes32 constant STORAGE_POSITION = keccak256("modules.smartaccount.plopmenz");

    struct Storage {
        mapping(bytes4 functionSelector => address module) getFunction;
    }

    function getStorage() internal pure returns (Storage storage s) {
        bytes32 position = STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }

    /// @notice Sets the interfaces implemented by this contract to (un)supported.
    function setInterfaces(bool supported) internal {
        SmartAccountERC165Lib.setInterfaceSupport(type(ISmartAccountModules).interfaceId, supported);
    }

    /// @notice Get the currently registered module for function.
    function getModule(bytes4 functionSelector) internal view returns (address module) {
        return getStorage().getFunction[functionSelector];
    }

    /// @notice Set the currently registered module for function.
    /// @dev Set to zero address to remove.
    function setModule(bytes4 functionSelector, address module) internal {
        getStorage().getFunction[functionSelector] = module;
        emit ModuleSet(functionSelector, module);
    }

    /// @notice Delegates the current msg call to a module, if one is registered for that function.
    function callModule() internal {
        // Get module from function selector
        address module = getModule(msg.sig);
        if (module == address(0)) {
            revert FunctionNotFound(msg.sig);
        }
        // Execute external function from module using delegatecall and return any value.
        assembly {
            // Copy function selector and any arguments
            calldatacopy(0, 0, calldatasize())
            // Execute function call using the module
            let result := delegatecall(gas(), module, 0, calldatasize(), 0, 0)
            // Get any return value
            returndatacopy(0, 0, returndatasize())
            // Return any return value or error back to the caller
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
}
