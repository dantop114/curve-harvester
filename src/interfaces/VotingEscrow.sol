// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.6;

struct LockedBalance {
    uint256 amount;
    uint256 end;
}

interface VotingEscrow {
    function locked() external view returns (LockedBalance memory);

    function create_lock(uint256, uint256) external;

    function increase_amount(uint256) external;

    function increase_unlock_time(uint256) external;

    function withdraw() external;
}
