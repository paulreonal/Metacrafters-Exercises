// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// ERC20 token implementation
contract MyERC20Token {
    string public constant name = "MyToken"; // Token name
    string public constant symbol = "MTK"; // Token symbol
    uint8 public constant decimals = 18; // Number of decimals

    uint256 private _totalSupply; // Total supply of the token
    address public owner; // Address of the contract owner
    mapping(address => uint256) private _balances; // Mapping from address to token balance
    mapping(address => mapping(address => uint256)) private _allowances; // Mapping from owner to spender to allowance

    // Modifier to restrict functions to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    // Constructor to set the initial supply and assign it to the deployer
    constructor(uint256 initialSupply) {
        owner = msg.sender;
        _mint(msg.sender, initialSupply);
    }

    // Function to get the total supply of the token
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    // Function to get the balance of a specific account
    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    // Function to transfer tokens to a recipient
    function transfer(address recipient, uint256 amount) external returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    // Function to get the allowance of a spender for a specific owner
    function allowance(address tokenOwner, address spender) external view returns (uint256) {
        return _allowances[tokenOwner][spender];
    }

    // Function to approve a spender to spend a specific amount of tokens
    function approve(address spender, uint256 amount) external returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    // Function to transfer tokens from a sender to a recipient using an allowance
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender] - amount);
        return true;
    }

    // Function to mint new tokens, only callable by the owner
    function mint(uint256 amount) external onlyOwner {
        _mint(msg.sender, amount);
    }

    // Function to burn tokens, reducing the total supply
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    // Internal function to handle transfers
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "Transfer from the zero address");
        require(recipient != address(0), "Transfer to the zero address");
        require(_balances[sender] >= amount, "Insufficient balance");

        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
    }

    // Internal function to mint new tokens
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "Mint to the zero address");

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    // Internal function to burn tokens
    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "Burn from the zero address");
        require(_balances[account] >= amount, "Insufficient balance to burn");

        _balances[account] -= amount;
        _totalSupply -= amount;
        emit Transfer(account, address(0), amount);
    }

    // Internal function to approve a spender
    function _approve(address tokenOwner, address spender, uint256 amount) internal {
        require(tokenOwner != address(0), "Approve from the zero address");
        require(spender != address(0), "Approve to the zero address");

        _allowances[tokenOwner][spender] = amount;
        emit Approval(tokenOwner, spender, amount);
    }

    // Event to log token transfers
    event Transfer(address indexed from, address indexed to, uint256 value);
    // Event to log approvals of token allowances
    event Approval(address indexed tokenOwner, address indexed spender, uint256 value);
}