// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.6;

import {Ownable} from "./access/Ownable.sol";
import {IERC20} from "./interfaces/IERC20.sol";
import {VestingEscrow} from "./interfaces/VestingEscrow.sol";
import {LockedBalance, VotingEscrow} from "./interfaces/VotingEscrow.sol";
import {FeeDistributor} from "./interfaces/FeeDistributor.sol";

contract CurveHarvester is Ownable {
    VestingEscrow public vestingEscrow;
    VotingEscrow public votingEscrow;
    FeeDistributor public feeDistributor;

    IERC20 public crvToken;

    uint256 public MAX_TIME = 4 * 365 * 86400; // from curve contract

    event VestingContractUpdated(address oldVC, address newVC);
    event VotingContractUpdated(address oldVC, address newVC);

    constructor(
        address _vestingAddress,
        address _votingAddress,
        address _feeDistributorAddress,
        address _crv
    ) Ownable() {
        vestingEscrow = VestingEscrow(_vestingAddress);
        votingEscrow = VotingEscrow(_votingAddress);
        feeDistributor = FeeDistributor(_feeDistributorAddress);
        crvToken = IERC20(_crv);
    }

    function claimAndLock() external onlyOwner {
        address addr = owner();
        uint256 balance = vestingEscrow.balanceOf(addr);

        require(balance > 0, "_balanceZero");

        vestingEscrow.claim(addr);

        require(
            crvToken.transferFrom(addr, address(this), balance),
            "_transferFrom"
        );

        LockedBalance memory lb = votingEscrow.locked();

        if (lb.amount != 0) {
            votingEscrow.increase_amount(balance);
        } else {
            votingEscrow.create_lock(balance, block.timestamp + MAX_TIME);
        }
    }

    function increaseUnlockTime() external onlyOwner {
        votingEscrow.increase_unlock_time(block.timestamp + MAX_TIME);
    }

    function withdrawCrv() external onlyOwner {
        LockedBalance memory lb = votingEscrow.locked();
        votingEscrow.withdraw();

        require(crvToken.transfer(owner(), lb.amount), "_transfer");
    }

    function harvest3Crv() external onlyOwner {
        uint256 amount = feeDistributor.claim();
        IERC20 token = IERC20(feeDistributor.token());

        require(token.transfer(owner(), amount), "_transfer");
    }
}
