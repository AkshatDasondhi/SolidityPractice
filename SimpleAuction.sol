// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SimpleAuction {
    
    uint256 startingBid;
    uint index = 0;

    struct Bid {
        string name;
        uint256 bid;
    }
    
    mapping(uint => Bid) public bidders;

    constructor(uint _startingBid) {
        startingBid = _startingBid;

    }

    function myBid(string calldata yourname, uint mybid) public {
        require(mybid > startingBid, "Bid lower than required starting bid.");
        bidders[index] = Bid({name: yourname, bid: mybid});
        index = index + 1;
    }

    function winner() public view returns (uint256) {
        uint256 maxbid = 0;
        string calldata maxbidder;
        for (uint i = 0; i < index ; i++){
            if (bidders[i].bid > maxbid) {
                maxbid = bidders[i].bid;
                maxbidder = bidders[i].name;
            }
        }

        return maxbid;
    }
}
