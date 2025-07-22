// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

import {Test} from "../../lib/forge-std/src/Test.sol";
import {console} from "../../lib/forge-std/src/console.sol";
import {Paragram} from "../../src/Paragram.sol";
import {InitializeActors} from "../utils/InitialiseActors.sol";
import {HonkVerifier} from "../../src/verifier.sol";

contract ParagramTest is Test, InitializeActors {
    Paragram public s_Paragram;
    HonkVerifier public s_Verifier;
    uint256 public Feild_MODULUS = 21888242871839275222246405745257275088548364400416034343698204186575808495617;// feild modulus 


    function setUp() public {
        vm.startPrank(Admin1);
        s_Paragram = new Paragram(s_Verifier);
        vm.stopPrank();
    }

    function testCreateNewRound() public {
        //string memory parrot = "parrot";
        bytes32 byte32Parrot = bytes32(uint256(keccak256("parrot")) % Feild_MODULUS);

        vm.startPrank(Admin1);
        s_Paragram.createNewRound(byte32Parrot);
        vm.stopPrank();
    }
}
