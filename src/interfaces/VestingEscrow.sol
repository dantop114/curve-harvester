// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.6;

interface VestingEscrow {
    function claim(address) external;

    function balanceOf(address) external view returns (uint256);
}
