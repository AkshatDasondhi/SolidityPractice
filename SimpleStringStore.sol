// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SimpleStorage {
    string public mystring;

    function set(string memory _mystring) external {
        mystring = _mystring;
    }

    function get() external view returns (string memory) {
        return mystring;
    }
}
