// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract protoContract {
    // State variables
    address public owner;    // Address of the contract owner
    uint256 public value;    
    bool public active;      // Flag to indicate contract activation status

    // Constructor to initialize contract state
    constructor() {
        owner = msg.sender;   // Set the contract owner as the deployer
        value = 0;            // Initialize starting value to 0
        active = true;        // Contract is initially active
    }

    // Modifier to allow only the contract owner to execute certain functions
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;  // Continue with the function if the condition is met
    }

    // Function to set the value, accessible only by the contract owner
    function setValue(uint256 _value) public onlyOwner {
        // Using require() to check for a condition
        require(_value >= 0, "Value must be non-negative");
        value = _value;  // Set the value
    }

    // Function to toggle the contract's active status, accessible only by the contract owner
    function toggleActive() public onlyOwner {
        // Using assert() to ensure internal logic correctness
        active = !active;  // Toggle active status
        assert(active == false || active == true);  // Ensure active flag is valid
    }

    // Function to demonstrate revert() for error handling, view function
    function revertProto() public view {
        // Using revert() to handle an error condition
        if (msg.sender != owner) {
            revert("You are not the owner");  // Revert with an error message
        }
    }

    // Function with require(), assert(), and conditional revert() for validation and error handling
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
