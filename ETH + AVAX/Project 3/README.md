# Project: Create a Token

This Solidity smart contract implements mint, transfer, and burn features in the ERC20 Token. It allows users to check their balances, transfer tokens to others, approve spending limits for other addresses, and transfer tokens on behalf of approved addresses. Additionally, the contract includes functions for minting new tokens (restricted to the contract owner) and burning tokens.

## Description

This a Solidity smart contract that exemplifies best practices and key features of Solidity programming. It begins with a constructor to initialize contract state variables, including the contract owner (owner), a value holder (value), and a contract activation flag (active). Additionally, the contract demonstrates error handling mechanisms through functions like 'revertProto' and 'protoFunction'. The former uses revert() to handle an error condition in a view function, while the latter showcases a combination of require(), assert(), and conditional revert() for input validation and specific error handling.

## Getting Started

### Executing program
To run this program, you can use Ethereum IDE, to run Solidity in a web browser. To get started, go to the Remix website at https://remix.ethereum.org/ then place the file, compile, then deploy.

### Steps to Compile and Deploy
# 1. Create a New File
Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar.
Save the file with a .sol extension (e.g., MyToken.sol).
Copy and paste the following code into the file:
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    // The constructor function is executed once when the contract is deployed
    // It takes an initial supply parameter to set the number of tokens created at deployment
    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") Ownable(msg.sender) {
        // Mint the specified initial supply to the deployer's address
        // Multiplying by 10 ** decimals() to account for the token's decimal places
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }

    // Define a function to mint new tokens, only accessible by the contract owner
    function mint(address to, uint256 amount) public onlyOwner {
        // Call the internal _mint function to create new tokens
        // Multiplying by 10 ** decimals() to account for the token's decimal places
        _mint(to, amount * 10 ** decimals());
    }

    // Define a function to burn tokens, accessible by anyone who holds tokens
    function burn(uint256 amount) public {
        // Call the internal _burn function to destroy tokens from the caller's balance
        // The amount is already in the smallest units, no need to multiply by decimals
        _burn(msg.sender, amount);
    }
}
```
# 2. Compile the Code
Click on the "Solidity Compiler" tab in the left-hand sidebar.
Make sure the "Compiler" option is set to "0.8.20" (or another compatible version).
Click on the "Compile MyToken.sol" button.

# 3. Deploy the Contract
Click on the "Deploy & Run Transactions" tab in the left-hand sidebar.
Select the MyToken contract from the dropdown menu.
In the initialSupply field, enter the initial supply of tokens (e.g., 1000).
Click on the "Deploy" button and confirm the transaction in MetaMask.

# 4. Interact with the Deployed Contract

Once the contract is deployed, you'll see it under "Deployed Contracts".
To mint tokens, input the recipient address and the amount, then click on mint.
To burn tokens, input the amount and click on burn.
To transfer tokens, use the transfer function by inputting the recipient address and the amount, then click on transfer.

## Help
This file is best supported in Ethereum Remix IDE for solana files. You can run this in your local IDE with a setup that supports solana files.
For other issues, please create an issue in this repository.

## Authors
Paul Miguel Reonal

## License
This project is not under any license as it is a student project for learning in Metacrafters.
