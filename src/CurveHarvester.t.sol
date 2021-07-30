// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./CurveHarvester.sol";

contract CurveHarvesterTest is DSTest {
    CurveHarvester harvester;
    VestingEscrow vestingEscrow;
    IERC20 crv;

    address _vestingEscrow = 0x575CCD8e2D300e2377B43478339E364000318E2c;
    address _votingEscrow = 0x5f3b5DfEb7B28CDbD7FAba78963EE202a494e2A2;
    address _feeDistributor = 0xA464e6DCda8AC41e03616F95f4BC98a13b8922Dc;
    address _crvToken = 0xD533a949740bb3306d119CC777fa900bA034cd52;

    function setUp() public {
        harvester = new CurveHarvester(
            _vestingEscrow,
            _votingEscrow,
            _feeDistributor,
            _crvToken
        );

        vestingEscrow = VestingEscrow(_vestingEscrow);
        crv = IERC20(_crvToken);

        harvester.transferOwnership(msg.sender);
    }
}
