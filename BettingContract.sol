// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SimpleBetting {
    struct Bet {
        address payable player;
        uint amount;
        uint team;
    }

    uint public numBets;
    uint public minBet;
    uint public totalBetOne;
    uint public totalBetTwo;
    address payable public owner;

    mapping(uint => Bet) public bets;

    constructor(uint _minBet){
        owner = payable(msg.sender);
        minBet = _minBet;
    }

    function bet(uint _team) public payable {
        require(msg.value >= minBet, "Bet should be higher than minimum bet");
        require(_team == 1 || _team == 2, "Invalid team");
        bets[numBets] = Bet(payable(msg.sender), msg.value, _team);
        if (_team == 1){
            totalBetOne += msg.value;
        } else {
            totalBetTwo += msg.value;
        }
        numBets++;
    }

    function distributePrizes(uint _winningTeam) public {
        require(msg.sender == owner, "Only owner can do this");
        uint totalBet = totalBetOne + totalBetTwo;
        uint winnerBet;
        if (_winningTeam == 1){
            winnerBet = totalBetOne;
        }else {
            winnerBet = totalBetTwo;
        }
        uint ownerFee = (totalBet / 100) * 5;
        uint winnerAmount = ((totalBet - ownerFee) * 100) / winnerBet;
        for (uint i = 0; i < numBets ; i++){
            if (bets[i].team == _winningTeam) {
                bets[i].player.transfer((bets[i].amount * winnerAmount) / 100);
            }
        }
        owner.transfer(ownerFee);
        totalBetOne = 0;
        totalBetTwo = 0;
        numBets = 0;
    }
}