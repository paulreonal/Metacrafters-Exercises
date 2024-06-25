# Project: Smart Contract

This Solidity smart contract manages deposits and withdrawals for a single owner. It makes use of multiple functions (getBalance, withdraw, and deposit). The contract stores the owner's address and the current balance. It includes functions for depositing and withdrawing funds, ensuring only the owner can perform these actions.

## Description
This program is a simple contract written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain. The contract has different functions that connnects our metacrafter wallet with our site and then there are three functions in the smart contract one is deposite function which is used for depositing second is withdraw function which is used for withdrawing and third is getbalance fuction which will show you your balance.

It's essential to connect the metamask wallet with our websites as all the data of transaction is going to store in the wallet address. Here hardhat node will provide us the local mainnet to test the functioning of the smart contract created.

## Getting Started

### Executing Program
Make sure that you have npm and nodejs in your system. If you already have those installed, but the commands are not working in VS Code, try running the IDE as administrator or check your PATHs. 

1. Inside the project directory, in the terminal type: 'npm i'
2. Open two additional terminals in your VS code
3. In the second terminal type: 'npx hardhat node'
4. In the third terminal, type: 'npx hardhat run --network localhost scripts/deploy.js'
5. Back in the first terminal, type 'npm run dev' to launch the front-end.

After this, the project will be running on your localhost. 
Typically at http://localhost:3000/

