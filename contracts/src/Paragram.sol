// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;


import {ERC1155} from "../lib/openzeppelin-contracts/contracts/token/ERC1155/ERC1155.sol";
import {IVerifier} from "./verifier.sol";
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";


contract Paragram is ERC1155, Ownable {
    // state var
    IVerifier public iVerifier; 
    uint8 public totalWinner;
    uint256 public s_RoundStartTime;
    address public s_CurentRoundWinner;
    uint256 public constant MAX_DURATION_TIME = 300;
    bytes32 public s_Answer;

    //error 
    error Paragram_NewRoundDurationNotReached(uint256 max_duration, uint256 time_difference);
    error Paragram_RoundWinnerAddressZero();

    // event 
    event verified(bool indexed isVerified);

    constructor(IVerifier _verifier) 
    ERC1155("ipfs://bafybeibmppdyko2eupdslqhtttlbog6u72do7kod25ea5hkq3wna3ir7gu/{id}.json") 
    Ownable(msg.sender)
        {
        iVerifier = _verifier;
    }

    function createNewRound(bytes32 _answer) public onlyOwner { 
        if (s_RoundStartTime == uint256(0)) {
            s_Answer = _answer;
            s_RoundStartTime = block.timestamp;
        } else {
            if (block.timestamp < (MAX_DURATION_TIME + s_RoundStartTime)) {
                revert Paragram_NewRoundDurationNotReached(MAX_DURATION_TIME, (block.timestamp - s_RoundStartTime));
            }

            if (s_CurentRoundWinner == address(0)) {
                revert Paragram_RoundWinnerAddressZero();
            }
        }

        // reset the round
        s_Answer = _answer;
        s_RoundStartTime = block.timestamp;
        s_CurentRoundWinner = address(0);
        
        // increment the state winners
        totalWinner++;
    }

    function submitNewGuesses() public {

    } 

    function setNewVerifier(IVerifier _verifier) public onlyOwner {
        iVerifier = _verifier;
    }
}