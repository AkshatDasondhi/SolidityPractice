// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SimpleToken {
    string public tokenname = "Aktoken";
    string public symbol = "God";
    uint public decimals = 15;
    uint256 public totaltokens = 50000;

    mapping(address => uint256) public balance;

    constructor() {
        balance[msg.sender] = totaltokens;
    }

    function transfer(address to, uint256 amount) public returns(bool) {
        require(amount > 0 , "Amount should not be 0");
        require(balance[msg.sender] >= amount, "Insufficient Balance");

        balance[msg.sender] -= amount;
        balance[to] += amount;

        emit Transfer(msg.sender, to, amount);

        return true;
    }

    event Transfer(address indexed from, address indexed to, uint256 amount);

}