// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

import {Test} from "../../lib/forge-std/src/Test.sol";
import {console} from "../../lib/forge-std/src/console.sol";
import {Paragram} from "../../src/Paragram.sol";

contract InitializeActors is Test {
    // ------------
    //    Actors
    // ------------

    // ADMIN:
    address public Admin1 = makeAddr("ADMIN1");
    address public Admin2 = makeAddr("ADMIN2");

    // PLAYERS:
    address public Player2 = makeAddr("Player2");
    address public player3 = makeAddr("Player3");

    // VERIFIER :
    address public verifer = makeAddr("ZKverifier");

    function getProof(bytes32 guess, bytes32 correctAnswer) internal returns (bytes memory result){
        uint256 num = 5;
        string[] memory inputs = new string[](num);

        inputs[0] = "npx";
        inputs[1] = "tsx";
        inputs[2] = "JS-Script/generateProof.ts";
        inputs[3] = vm.toString(guess);
        inputs[4] = vm.toString(correctAnswer);

        return vm.ffi(inputs);
    } 
}