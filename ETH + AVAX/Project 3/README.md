# Project: Create a Token

This Solidity smart contract implements mint, transfer, and burn features in the ERC20 Token. It allows users to check their balances, transfer tokens to others, approve spending limits for other addresses, and transfer tokens on behalf of approved addresses. Additionally, the contract includes functions for minting new tokens (restricted to the contract owner) and burning tokens.

## Description

This a Solidity smart contract that exemplifies best practices and key features of Solidity programming. It begins with a constructor to initialize contract state variables, including the contract owner (owner), a value holder (value), and a contract activation flag (active). Additionally, the contract demonstrates error handling mechanisms through functions like 'revertProto' and 'protoFunction'. The former uses revert() to handle an error condition in a view function, while the latter showcases a combination of require(), assert(), and conditional revert() for input validation and specific error handling.

## Getting Started

### Executing program
To run this program, you can use Ethereum IDE, to run Solidity in a web browser. To get started, go to the Remix website at https://remix.ethereum.org/ then place the file, compile, then deploy.

### Steps to Compile and Deploy
#### 1. Create a New File
Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar.
Save the file with a .sol extension (e.g., MyToken.sol).
Copy and paste the following code into the file:
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "@openzeppelin/contracts/utils/Context.sol";

contract MyToken is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    address private _owner;

    modifier onlyOwner() {
        require(_msgSender() == _owner, "Not the owner");
        _;
    }

    constructor(string memory name_, string memory symbol_, uint256 initialSupply) {
        _name = name_;
        _symbol = symbol_;
        _owner = _msgSender();
        _mint(_owner, initialSupply);
    }

    function name() public view virtual override returns (string memory) {
        return _name;
    }

    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 value) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, value);
        return true;
    }

    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 value) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }

    function mint(address account, uint256 value) public onlyOwner {
        _mint(account, value);
    }

    function burn(uint256 value) public {
        _burn(_msgSender(), value);
    }

    function _transfer(address from, address to, uint256 value) internal {
        require(from != address(0), "ERC20: transfer from zero address");
        require(to != address(0), "ERC20: transfer to zero address");

        uint256 fromBalance = _balances[from];
        require(fromBalance >= value, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - value;
        }
        _balances[to] += value;

        emit Transfer(from, to, value);
    }

    function _mint(address account, uint256 value) internal {
        require(account != address(0), "ERC20: mint to zero address");

        _totalSupply += value;
        _balances[account] += value;
        emit Transfer(address(0), account, value);
    }

    function _burn(address account, uint256 value) internal {
        require(account != address(0), "ERC20: burn from zero address");

        uint256 accountBalance = _balances[account];
        require(accountBalance >= value, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - value;
        }
        _totalSupply -= value;

        emit Transfer(account, address(0), value);
    }

    function _approve(address owner, address spender, uint256 value) internal {
        require(owner != address(0), "ERC20: approve from zero address");
        require(spender != address(0), "ERC20: approve to zero address");

        _allowances[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    function _spendAllowance(address owner, address spender, uint256 value) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= value, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - value);
            }
        }
    }
}
```
#### 2. Compile the Code
Click on the "Solidity Compiler" tab in the left-hand sidebar.
Make sure the "Compiler" option is set to "0.8.20" (or another compatible version).
Click on the "Compile MyToken.sol" button.

#### 3. Deploy the Contract
Click on the "Deploy & Run Transactions" tab in the left-hand sidebar.
Select the MyToken contract from the dropdown menu.
In the initialSupply field, enter the initial supply of tokens (e.g., 1000).
Click on the "Deploy" button and confirm the transaction in MetaMask.

#### 4. Interact with the Deployed Contract

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
