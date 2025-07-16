// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;


import {ERC1155} from "../lib/openzeppelin-contracts/contracts/token/ERC1155/ERC1155.sol";
import {IVerifier} from "./verifier.sol";
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";


contract Paragram is ERC1155, Ownable {

    IVerifier public iVerifier;

    event verified(bool indexed isVerified);

    constructor(IVerifier _verifier) 
    ERC1155("ipfs://bafybeibmppdyko2eupdslqhtttlbog6u72do7kod25ea5hkq3wna3ir7gu/{id}.json") 
    Ownable(msg.sender)
        {
        iVerifier = _verifier;
    }

    function createNewRound( ) public {

    }

    function submitNewGuesses() public {

    } 

    function setNewVerifier(IVerifier _verifier) public onlyOwner {
        iVerifier = _verifier;
    }
}