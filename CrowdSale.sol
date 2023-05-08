// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract CrowdSale {
    address payable public owner;
    address payable public benificiary;
    uint public goal;
    uint public deadline;
    uint public price;
    uint public raisedamount;

    mapping (address => uint) public balanceof;
    bool goalreached = false;
    bool saleclosed = false;

    event GoalReached(address benificiary, uint raisedamount);
    event FundTransfer(address backer , uint amount , bool isContribution);

    constructor(address payable _benificiary , uint _fundinggoal,uint _duration , uint _tokencost){
        owner = payable(msg.sender);
        benificiary = _benificiary;
        goal = _fundinggoal * 1 ether;
        deadline = block.timestamp + (_duration * 1 minutes);
        price = _tokencost * 1 ether;

    }

    function transfered() external payable {
        require(!saleclosed);
        uint amount = msg.value;
        balanceof[msg.sender] += amount;
        raisedamount += amount;
        emit FundTransfer(msg.sender , amount , true);
    }

    modifier afterdeadline() {
        if (block.timestamp >= deadline){
            _;
        }
    }

    function checkgoalreached() public afterdeadline {
        if (raisedamount >= goal) {
            goalreached = true;
            emit GoalReached(benificiary , raisedamount);
        }   
        saleclosed = true;
    }

    function withdrawal() public afterdeadline {
        if (!goalreached) {
            uint amount = balanceof[msg.sender];
            balanceof[msg.sender] = 0;
            if (amount > 0) {
                payable(msg.sender).transfer(amount);
                emit FundTransfer(msg.sender, amount, false);
            }
        }

        if(goalreached && owner == msg.sender) {
            payable(owner).transfer(raisedamount);
            emit FundTransfer(owner, raisedamount, false);
        }
    }

}