// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Degen {
    uint256 public totalSupply; // Total supply of DEGEN tokens
    address public owner; // Owner of the contract
    string public constant name = "DEGEN"; // Token name
    string public constant symbol = "DGN"; // Token symbol
    uint8 public decimals = 18; // Token decimals

    constructor() {
        owner = msg.sender; // Set contract deployer as owner
    }

    mapping(address => uint256) public balances; // Balances of each address
    mapping(address => uint256[]) public redeemedItems; // Redeemed items for each address

    event TokensMinted(address indexed to, uint256 amount);
    event TokensBurned(address indexed from, uint256 amount);
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event ItemRedeemed(address indexed to, uint256 gameItem);

    function mint(address to, uint256 amount) public {
        require(msg.sender == owner, "Only the contract owner can mint tokens.");
        require(amount > 0, "Amount must be greater than 0.");
        balances[to] += amount; // Increase recipient's balance
        totalSupply += amount; // Increase total supply
        emit TokensMinted(to, amount);
    }

    function burn(address from, uint256 amount) public {
        require(amount <= balances[from], "Amount exceeds balance.");
        balances[from] -= amount; // Decrease sender's balance
        totalSupply -= amount; // Decrease total supply
        emit TokensBurned(from, amount);
    }

    function transfer(address to, uint256 amount) public {
        require(amount <= balances[msg.sender], "Amount exceeds balance.");
        require(to != address(0), "Cannot transfer to the zero address.");
        balances[msg.sender] -= amount; // Decrease sender's balance
        balances[to] += amount; // Increase recipient's balance
        emit Transfer(msg.sender, to, amount);
    }

    function redeem(address to, uint256 amount, uint256 gameItem) public {
        require(amount <= balances[to], "Amount exceeds balance");

        if (gameItem == 1) {
            require(amount >= 50, "Insufficient tokens for Game Item 1");
            burn(to, amount);
        } else if (gameItem == 2) {
            require(amount >= 100, "Insufficient tokens for Game Item 2");
            burn(to, amount);
        } else if (gameItem == 3) {
            require(amount >= 200, "Insufficient tokens for Game Item 3");
            burn(to, amount);
        } else {
            revert("Invalid game item");
        }

        redeemedItems[to].push(gameItem); // Store the redeemed item
        emit ItemRedeemed(to, gameItem); // Emit event for item redemption
    }
}
