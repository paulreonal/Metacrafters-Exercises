// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Degen {

    // State variables
    uint256 public totalSupply;  // Total supply of the token
    address public owner;        // Owner of the contract
    string public constant name = "DEGEN"; // Name of the token
    string public constant symbol = "DGN"; // Symbol of the token
    uint8 public decimals = 18;   // Decimal places for the token

    // Constructor to set the contract owner
    constructor() {
        owner = msg.sender;
    }

    // Mapping to keep track of balances
    mapping(address => uint256) public balances;

    // Mint function to create new tokens
    function mint(address to, uint256 amount) public {
        // Only the owner can mint tokens
        require(msg.sender == owner, "Only the contract owner can mint tokens.");
        // Amount must be greater than 0
        require(amount > 0, "Amount must be greater than 0.");

        // Increase the balance of the receiver and the total supply
        balances[to] += amount;
        totalSupply += amount;
    }

    // Burn function to destroy tokens
    function burn(address from, uint256 amount) public {
        // Ensure the amount to burn does not exceed the balance
        require(amount <= balances[from], "Amount exceeds balance.");

        // Decrease the balance of the sender and the total supply
        balances[from] -= amount;
        totalSupply -= amount;
    }

    // Transfer function to send tokens to another address
    function transfer(address to, uint256 amount) public {
        // Ensure the sender has enough tokens
        require(amount <= balances[msg.sender], "Amount exceeds balance.");
        // Ensure the receiver is not the zero address
        require(to != address(0), "Cannot transfer to the zero address.");

        // Transfer the tokens
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    // Redeem function to trade tokens for game items
    function redeem(address to, uint256 amount, uint256 gameItem) public {
        // Ensure the amount to redeem does not exceed the balance
        require(amount <= balances[to], "Amount exceeds balance");

        // Redeem the tokens for the specified game item
        if (gameItem == 1) {
            // Check if enough tokens for Game Item 1
            require(amount >= 50, "Insufficient tokens for Game Item 1");
            burn(to, amount);
        } else if (gameItem == 2) {
            // Check if enough tokens for Game Item 2
            require(amount >= 100, "Insufficient tokens for Game Item 2");
            burn(to, amount);
        } else if (gameItem == 3) {
            // Check if enough tokens for Game Item 3
            require(amount >= 200, "Insufficient tokens for Game Item 3");
            burn(to, amount);
        } else {
            // Invalid game item
            revert("Invalid game item");
        }
    }
}
