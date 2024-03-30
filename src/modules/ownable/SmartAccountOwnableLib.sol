// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SmartAccountERC165Lib} from "../erc165/SmartAccountERC165Lib.sol";

import {ISmartAccountOwnable} from "./ISmartAccountOwnable.sol";

library SmartAccountOwnableLib {
    /// @notice The caller account is not authorized to perform an operation.
    error NotOwner(address account, address owner);

    /// @notice A (new) account has become the owner of this contract.
    event NewOwner(address account);

    bytes32 constant STORAGE_POSITION = keccak256("ownable.modules.smartaccount.plopmenz");

    struct Storage {
        address owner;
    }

    function getStorage() internal pure returns (Storage storage s) {
        bytes32 position = STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }

    /// @notice Sets the interfaces implemented by this contract to (un)supported.
    function setInterfaces(bool supported) internal {
        SmartAccountERC165Lib.setInterfaceSupport(type(ISmartAccountOwnable).interfaceId, supported);
    }

    /// @notice Returns the address of the current owner.
    function owner() internal view returns (address) {
        return getStorage().owner;
    }

    /// @notice Reverts if `account` is not the current owner.
    function ensureIsOwner(address account) internal view {
        if (account != owner()) {
            revert NotOwner(account, owner());
        }
    }

    /// @notice Sets the address of the current owner.
    function setOwner(address account) internal {
        getStorage().owner = account;
        emit NewOwner(account);
    }
}
