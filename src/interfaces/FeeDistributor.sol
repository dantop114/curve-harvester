// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.6;

interface FeeDistributor {
    function claim() external returns (uint256);

    function token() external view returns (address);
}
