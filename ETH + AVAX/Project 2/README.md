# Project: Grocery Item Smart Contract

This Solidity program is a decentralized application specifically designed for the management of grocery items. It serves as a comprehensive example of how to implement the fundamental features required for listing, purchasing, and overseeing grocery items within a blockchain environment, particularly on the Ethereum network.

## Description
The DApp is built using Solidity, the primary language for writing smart contracts on the Ethereum blockchain. It provides users with the ability to interact with the blockchain to perform various operations related to grocery items. This includes the creation of listings for items, the facilitation of secure purchases, and the management of item details and statuses. By leveraging the decentralized nature of blockchain technology, this application ensures that all transactions are transparent, secure, and immutable.

In addition to the Solidity smart contract, the DApp includes a frontend interface built with React and ethers.js. This interface allows users to interact with the smart contract seamlessly. Through the frontend, users can list new items, view available items, make purchases, and manage their items, all while directly interacting with the Ethereum blockchain. This integration ensures a user-friendly experience and makes the decentralized features of the application accessible to a wider audience.

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

