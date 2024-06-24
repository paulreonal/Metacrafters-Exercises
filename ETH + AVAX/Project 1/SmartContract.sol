// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract protoContract {
    address public owner;
    uint256 public value;
    bool public active;

    constructor() {
        owner = msg.sender;
        value = 0;
        active = true;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    function setValue(uint256 _value) public onlyOwner {
        // Using require() to check for a condition
        require(_value >= 0, "Value must be non-negative");
        value = _value;
    }

    function toggleActive() public onlyOwner {
        // Using assert() to ensure internal logic correctness
        active = !active;
        assert(active == false || active == true);
    }

    function revertProto() public view {
        // Using revert() to handle an error condition
        if (msg.sender != owner) {
            revert("You are not the owner");
        }
    }

    function protoFunction(uint256 _value) public {
        // Using require() to validate inputs
        require(_value > 0, "Value must be greater than 0");

        // Some internal logic
        value += _value;

        // Using assert() to ensure internal consistency
        assert(value >= _value);

        // Conditional revert() for specific error handling
        if (value > 1000) {
            revert("Value exceeds the maximum limit of 1000");
        }
    }
}
