# Project: Create a Token

This Solidity smart contract implements mint, transfer, and burn features in the ERC20 Token. It allows users to check their balances, transfer tokens to others, approve spending limits for other addresses, and transfer tokens on behalf of approved addresses. Additionally, the contract includes functions for minting new tokens (restricted to the contract owner) and burning tokens.

## Description

This a Solidity smart contract that exemplifies best practices and key features of Solidity programming. It begins with a constructor to initialize contract state variables, including the contract owner (owner), a value holder (value), and a contract activation flag (active). Additionally, the contract demonstrates error handling mechanisms through functions like 'revertProto' and 'protoFunction'. The former uses revert() to handle an error condition in a view function, while the latter showcases a combination of require(), assert(), and conditional revert() for input validation and specific error handling.

## Getting Started

### Executing program
To run this program, you can use Ethereum IDE, to run Solidity in a web browser. To get started, go to the Remix website at https://remix.ethereum.org/ then place the file, compile, then deploy.

## Help
This file is best supported in Ethereum Remix IDE for solana files. You can run this in your local IDE with a setup that supports solana files.
For other issues, please create an issue in this repository.

## Authors
Paul Miguel Reonal

## License
This project is not under any license as it is a student project for learning in Metacrafters.
