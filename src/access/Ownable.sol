// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.6;

contract Ownable {
    address private _owner;

    error NotOwner();

    modifier onlyOwner() {
        if(msg.sender != _owner) revert NotOwner();

        _;
    }

    constructor() {
        _owner = msg.sender;
    }

    function transferOwnership(address to) external onlyOwner {
        require(to != address(0), '_addressZero');
        _owner = to;
    }

    function renounceOwnership() external onlyOwner {
        _owner = address(0);
    }

    function owner() public view returns(address) {
        return _owner;
    }
}
