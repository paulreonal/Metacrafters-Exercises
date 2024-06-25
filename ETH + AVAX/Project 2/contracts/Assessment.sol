// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment the line below to enable console logs for debugging in Hardhat
// import "hardhat/console.sol";

contract Assessment {
    // Address of the owner of the contract
    address payable public owner;
    // Current balance of the contract
    uint256 public balance;

    // Event triggered when a deposit is made
    event Deposit(uint256 amount);
    // Event triggered when a withdrawal is made
    event Withdraw(uint256 amount);

    // Constructor to initialize the contract with an initial balance
    constructor(uint initBalance) payable {
        // Set the owner to the address that deployed the contract
        owner = payable(msg.sender);
        // Set the initial balance
        balance = initBalance;
    }

    // Function to get the current balance of the contract
    function getBalance() public view returns(uint256){
        return balance;
    }

    // Function to deposit an amount into the contract
    function deposit(uint256 _amount) public payable {
        // Store the previous balance for assertion
        uint _previousBalance = balance;

        // Ensure that only the owner can deposit
        require(msg.sender == owner, "You are not the owner of this account");

        // Perform the deposit by adding the amount to the balance
        balance += _amount;

        // Assert that the balance has increased correctly
        assert(balance == _previousBalance + _amount);

        // Emit the deposit event
        emit Deposit(_amount);
    }

    // Custom error for insufficient balance during withdrawal
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    // Function to withdraw an amount from the contract
    function withdraw(uint256 _withdrawAmount) public {
        // Ensure that only the owner can withdraw
        require(msg.sender == owner, "You are not the owner of this account");

        // Store the previous balance for assertion
        uint _previousBalance = balance;

        // Check if the balance is sufficient for the withdrawal
        if (balance < _withdrawAmount) {
            // Revert the transaction with a custom error if the balance is insufficient
            revert InsufficientBalance({
                balance: balance,
                withdrawAmount: _withdrawAmount
            });
        }

        // Perform the withdrawal by subtracting the amount from the balance
        balance -= _withdrawAmount;

        // Assert that the balance has decreased correctly
        assert(balance == (_previousBalance - _withdrawAmount));

        // Emit the withdrawal event
        emit Withdraw(_withdrawAmount);
    }
}
