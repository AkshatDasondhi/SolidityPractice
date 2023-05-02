// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SimpleVoting {
    uint public numproposals;

    struct Proposal {
        string name;
        uint votecount;
    }

    mapping(uint => Proposal) public proposals;

    constructor(uint _numproposals) {
        numproposals = _numproposals;

        for (uint i = 0; i < numproposals ; i++){
            proposals[i] = Proposal({name: "", votecount: 0});
        }
    }

    function vote(uint proposal) public {
        require(proposal >= 0 && proposal < numproposals , "Invalid Proporsal");

        proposals[proposal].votecount++;
    }

    function winningproporsal() public view returns (uint) {
        uint winningvotecount = 0;
        uint winningproporsalindex = 0;

        for (uint i = 0; i < numproposals ; i++){
            if (proposals[i].votecount > winningvotecount) {
                winningvotecount = proposals[i].votecount;
                winningproporsalindex = i;
            }
        }

        return winningproporsalindex;
    }
}
