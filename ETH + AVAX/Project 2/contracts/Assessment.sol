// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Assessment {
    address payable public owner; // Owner's address (teacher or principal)
    uint256 public balance; // Contract balance (total points available for rewards)

    // Event for deposits (e.g., points added to the reward pool)
    event Deposit(uint256 amount);

    // Event for withdrawals (e.g., points given to students as rewards)
    event Withdraw(uint256 amount);

    // Constructor to initialize the contract with an initial balance
    constructor(uint initBalance) payable {
        owner = payable(msg.sender); // Set contract owner (person responsible for managing rewards)
        balance = initBalance; // Initialize balance (starting points available for rewards)
    }

    // Custom error for insufficient balance (not enough points to give out as rewards)
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    // Function to get the current balance of the contract (check how many points are available)
    function getBalance() public view returns (uint256) {
        return balance; // Return current balance
    }

    // Function to deposit an amount into the contract (add points to the reward pool)
    function deposit(uint256 _amount) public payable {
        require(msg.sender == owner, "You are not the owner of this account"); // Only owner can deposit (only the teacher can add points)

        uint _previousBalance = balance; // Previous balance for assertion
        balance += _amount; // Update balance (e.g., add points to the pool)

        assert(balance == _previousBalance + _amount); // Check balance update
        emit Deposit(_amount); // Emit deposit event
    }

    // Function to withdraw an amount from the contract (e.g., give points to students as rewards)
    function withdraw(uint256 _withdrawAmount) public {
        require(msg.sender == owner, "You are not the owner of this account"); // Only owner can withdraw (only the teacher can give out points)

        uint _previousBalance = balance; // Previous balance for assertion
        if (balance < _withdrawAmount) {
            revert InsufficientBalance({
                balance: balance,
                withdrawAmount: _withdrawAmount
            }); // Revert if balance is insufficient (not enough points to give out)
        }

        balance -= _withdrawAmount; // Update balance (subtract points from the pool)
        assert(balance == _previousBalance - _withdrawAmount); // Check balance update

        emit Withdraw(_withdrawAmount); // Emit withdrawal event
    }
}
