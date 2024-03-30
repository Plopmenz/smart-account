// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC165} from "../../../lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol";

library SmartAccountERC165Lib {
    /// @notice Interface support changed.
    event InterfaceSupportedChanged(bytes4 indexed interfaceId, bool supported);

    bytes32 constant STORAGE_POSITION = keccak256("modules.smartaccount.plopmenz");

    struct Storage {
        mapping(bytes4 interfaceId => bool supported) getSupported;
    }

    function getStorage() internal pure returns (Storage storage s) {
        bytes32 position = STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }

    /// @notice Gets the interfaces supported by the Smart Account.
    function supportsInterface(bytes4 interfaceId) internal view returns (bool supported) {
        return getStorage().getSupported[interfaceId];
    }

    /// @notice Updates the interfaces supported by the Smart Account.
    function setInterfaceSupport(bytes4 interfaceId, bool supported) internal {
        getStorage().getSupported[interfaceId] = supported;
        emit InterfaceSupportedChanged(interfaceId, supported);
    }
}
