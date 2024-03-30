// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC165} from "../../../lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol";

interface ISmartAccountERC165 is IERC165 {
    /// @notice Interface support changed.
    event InterfaceSupportedChanged(bytes4 indexed interfaceId, bool supported);
}
