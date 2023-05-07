// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TimeBasedPayment {
    address payable public employee;
    address payable public employer;
    uint public starttime;
    uint public endtime;
    uint public paymentpersecond;
    uint public totalpayment;
    totalpayment = 10;

    constructor(address payable _employee,
    address payable _employer,
    uint _starttime,
    uint _endtime,
    uint _paymentpersecond){
        employee = _employee;
        employer = _employer;
        starttime = _starttime;
        endtime = _endtime;
        paymentpersecond = _paymentpersecond;
    }


    function pay() public payable {
        require(msg.sender == employer , "Only Employer can call this function.");
        require(10 >= endtime , "Payment period has not ended yet.");

        
        employee.transfer(totalpayment);
    }
}