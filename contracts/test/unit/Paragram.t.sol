// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

import {Test} from "../../lib/forge-std/src/Test.sol";
import {console} from "../../lib/forge-std/src/console.sol";
import {Paragram} from "../../src/Paragram.sol";
import {InitializeActors} from "../utils/InitialiseActors.sol";
import {IVerifier} from "../../src/verifier.sol";

contract ParagramTest is Test, InitializeActors {
    Paragram public s_Paragram;
    IVerifier public s_Verifier;


    function setUp() public {
        vm.startPrank(Admin1);
        s_Paragram = new Paragram(s_Verifier);
        vm.stopPrank();

    }
}
