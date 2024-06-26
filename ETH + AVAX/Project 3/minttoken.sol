// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "@openzeppelin/contracts/utils/Context.sol";

// MyToken implements the IERC20 and IERC20Metadata interfaces.
contract MyToken is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;

    // Set token name and symbol during deployment
    constructor(string memory name_, string memory symbol_, uint256 initialSupply) {
        _name = name_;
        _symbol = symbol_;
        _mint(_msgSender(), initialSupply);
    }

    // Return the name of the token
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    // Return the symbol of the token
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    // Return the number of decimals
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    // Return the total supply of tokens
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    // Return the balance of a specific account
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    // Transfer tokens to a specified address
    function transfer(address to, uint256 value) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, value);
        return true;
    }

    // Return the remaining number of tokens that spender can spend
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    // Approve spender to use a certain amount of tokens
    function approve(address spender, uint256 value) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, value);
        return true;
    }

    // Transfer tokens from one address to another using allowance mechanism
    function transferFrom(address from, address to, uint256 value) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }

    // Internal transfer function
    function _transfer(address from, address to, uint256 value) internal {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        uint256 fromBalance = _balances[from];
        require(fromBalance >= value, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - value;
        }
        _balances[to] += value;

        emit Transfer(from, to, value);
    }

    // Mint new tokens and assign them to an account
    function _mint(address account, uint256 value) internal {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply += value;
        _balances[account] += value;
        emit Transfer(address(0), account, value);
    }

    // Burn tokens from an account
    function _burn(address account, uint256 value) internal {
        require(account != address(0), "ERC20: burn from the zero address");

        uint256 accountBalance = _balances[account];
        require(accountBalance >= value, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - value;
        }
        _totalSupply -= value;

        emit Transfer(account, address(0), value);
    }

    // Set allowance for spender
    function _approve(address owner, address spender, uint256 value) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    // Spend allowance for spender
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
