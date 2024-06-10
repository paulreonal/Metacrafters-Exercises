// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract AwesomeToken {

    // Public variables to store details about the token
    string public tokenName = "AwesomeToken";
    string public tokenAbbrv = "ATK";
    uint256 public totalSupply = 0;

    // Mapping to store balances of addresses
    mapping(address => uint256) public balances;

    // Mint function to increase the total supply and the balance of the sender address
    function mint(address to, uint256 value) public {
        totalSupply += value;
        balances[to] += value;
    }

    // Burn function to decrease the total supply and the balance of the sender address
    function burn(address from, uint256 value) public {
        require(balances[from] >= value, "Insufficient balance to burn");
        totalSupply -= value;
        balances[from] -= value;
    }
}
