# Project: Smart Contract

This Solidity smart contract manages deposits and withdrawals for a single owner. It makes use of multiple functions (getBalance, withdraw, and deposit). The contract stores the owner's address and the current balance. It includes functions for depositing and withdrawing funds, ensuring only the owner can perform these actions.

## Description
This program is a simple contract written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain. The contract has different functions that connnects our metacrafter wallet with our site and then there are three functions in the smart contract one is deposite function which is used for depositing second is withdraw function which is used for withdrawing and third is getbalance fuction which will show you your balance.

It's essential to connect the metamask wallet with our websites as all the data of transaction is going to store in the wallet address. Here hardhat node will provide us the local mainnet to test the functioning of the smart contract created.

## Getting Started
### Installing
Either run this project on gitpod or clone this locally in your computer's IDE. If you chose to run this locally, make sure that you have npm and npx installed in your local system. You can install this at their website .

### Executing Program
Make sure that you have npm and nodejs in your system. If you already have those installed, but the commands are not working in VS Code, try running the IDE as administrator or check your PATHs. 

1. Inside the project directory, in the terminal type: 'npm i'
2. Open two additional terminals in your VS code
3. In the second terminal type: 'npx hardhat node'
4. In the third terminal, type: 'npx hardhat run --network localhost scripts/deploy.js'
5. Back in the first terminal, type 'npm run dev' to launch the front-end.

After this, the project will be running on your localhost. 
Typically at http://localhost:3000/

## Help
A common issue is running the application locally because you have to make sure that the pre-requisites are already downloaded and their paths are already setup.
It is suggested to run this in Remix 'https://remix.ethereum.org/' to easily run the program without worrying with the pre-requisites and setup.

For other issues, please create an issue in this repository.

## Authors
Paul Miguel Reonal

## License
This project is not under any license as it is a student project for learning in Metacrafters.

