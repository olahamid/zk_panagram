// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

import {ERC1155} from "../lib/openzeppelin-contracts/contracts/token/ERC1155/ERC1155.sol";
import {IVerifier} from "./verifier.sol";
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";


contract Paragram is ERC1155, Ownable {
    // state var
    IVerifier public s_Verifier; 
    uint8 public s_totalWinner;
    uint256 public s_RoundStartTime;
    address public s_CurentRoundWinner;
    address public s_latestWinner;
    uint256 public constant MAX_DURATION_TIME = 300;
    bytes32 public s_Answer;

    mapping (address user => uint8 guessRound) m_currentRound;


    //error 
    error Paragram_NewRoundDurationNotReached(uint256 max_duration, uint256 time_difference);
    error paragram_alreadyGuessedCorrectly(address user, uint8 totalWinners);
    error Paragram_invalidZKVerification(bool verify);
    error Paragram_RoundWinnerAddressZero();
    error Paragram_StartTimeAtZero();

    // event 
    event Paragram__verified(IVerifier _verifier, bool indexed isVerified);
    event Paragram__NewRoundStarted(bytes32 __answer);
    event Paragram__winnerMinted(address indexed winner, uint8 indexed currentRound);
    event Paragram__RunnerUpMinted(address  indexed runnerUp, uint8 indexed currentRound);

    constructor(IVerifier _verifier) 
    ERC1155("ipfs://bafybeibmppdyko2eupdslqhtttlbog6u72do7kod25ea5hkq3wna3ir7gu/{id}.json") 
    Ownable(msg.sender)
        {
        s_Verifier = _verifier;
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
                    // reset the round
            s_Answer = _answer;
            s_RoundStartTime = block.timestamp;
            s_CurentRoundWinner = address(0);
        }
        
        // increment the state winners
        s_totalWinner++;
        emit Paragram__NewRoundStarted(_answer);
    }

    function submitNewGuesses(bytes memory proof) public returns(bool) {
        // check that the start time isnt zero 
        if (s_RoundStartTime == 0 ) {
            revert Paragram_StartTimeAtZero();
        }
        // check if the user have already guessed correctely to prevent double guesses
        uint8 currentRound = s_totalWinner;
        if (m_currentRound[msg.sender] == currentRound) {
            revert paragram_alreadyGuessedCorrectly(msg.sender, currentRound);
        }
        // check that the verifier is returning true 
        bytes32[] memory input = new bytes32[](1);
        input[0] = s_Answer;
        bool isVerified = s_Verifier.verify(proof, input);
        // if bool is returning fasle , revert invalid
        if (isVerified == false ) {
            revert Paragram_invalidZKVerification(isVerified);
        } else {
        // if bool is true return true, store the mapping addr and mint both winner and runner up
            m_currentRound[msg.sender] = currentRound;
            if (s_latestWinner == address(0)) { 
                s_latestWinner = msg.sender;
                _mint(msg.sender, 0, 1, "");
                emit Paragram__winnerMinted(msg.sender, currentRound);
            } else {
                _mint(msg.sender,1, 1," ");
                emit Paragram__RunnerUpMinted(msg.sender, currentRound);
            }
        }
        return isVerified;
    } 

    function setNewVerifier(IVerifier _verifier) public onlyOwner {
        s_Verifier = _verifier;
        emit Paragram__verified(_verifier, true);
    }
}