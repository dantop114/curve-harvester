pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./CurveHarvester.sol";

contract CurveHarvesterTest is DSTest {
    CurveHarvester harvester;

    function setUp() public {
        harvester = new CurveHarvester();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
