// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SimpleLottery {
    address payable[] public players;
    address public manager;
    uint public ticketPrice;
    uint public minPlayers;
    uint public randomSeed;
    bool public isComplete;

    constructor(uint _ticketPrice, uint _minPlayers) {
        manager = msg.sender;
        ticketPrice = _ticketPrice;
        minPlayers = _minPlayers;
        randomSeed = 0;
        isComplete = false;
    }

    function enter() public payable {
        require(msg.value == ticketPrice ,"Enter the valid ticket price");
        require(players.length < 5 , "Maximum players limit reached.");
        players.push(payable(msg.sender));
    }

    function pickWinner() public restricted {
        require(players.length >= 5 , "Not enough players");
        require(!isComplete, "Lottery is complete");
        uint winnerIndex = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, randomSeed))) % players.length;
        players[winnerIndex].transfer(address(this).balance);
        isComplete = true;
    }

    function setRandomSeed(uint _randomSeed) public restricted {
        randomSeed = _randomSeed;
    }

    function getPlayers() public view returns (address payable[] memory){
        return players;
    }

    modifier restricted(){
        require(msg.sender == manager, "Only manager can do this");
        _;
    }
}