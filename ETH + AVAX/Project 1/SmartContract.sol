// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract SchoolGradingSystem {
    address public admin;
    mapping(address => uint256) public grades;
    bool public systemActive;

    constructor() {
        admin = msg.sender;
        systemActive = true;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not the admin");
        _;
    }

    function setGrade(address student, uint256 grade) public onlyAdmin {
        // Using require() to check for a valid grade
        require(grade >= 0 && grade <= 100, "Grade must be between 0 and 100");
        grades[student] = grade;
    }

    function toggleSystemActive() public onlyAdmin {
        // Using assert() to ensure internal logic correctness
        systemActive = !systemActive;
        assert(systemActive == false || systemActive == true);
    }

    function revertIfNotAdmin() public view {
        // Using revert() to handle an error condition
        if (msg.sender != admin) {
            revert("You are not the admin");
        }
    }

    function adjustGrade(address student, uint256 increment) public {
        // Using require() to validate inputs
        require(increment > 0, "Increment must be greater than 0");

        // Some internal logic
        grades[student] += increment;

        // Using assert() to ensure internal consistency
        assert(grades[student] >= increment);

        // Conditional revert() for specific error handling
        if (grades[student] > 100) {
            revert("Grade exceeds the maximum limit of 100");
        }
    }
}
