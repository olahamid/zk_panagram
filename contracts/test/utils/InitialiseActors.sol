// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

import {Test} from "../../lib/forge-std/src/Test.sol";
import {console} from "../../lib/forge-std/src/console.sol";
import {Paragram} from "../../src/Paragram.sol";

contract InitializeActors is Test {
    // ------------
    //    Actors
    // ------------

    // ** ADMIN ACTORS: PROPOSED BY THE PROTOCOL **
    address protocolTeamMultisig = makeAddr("mulprotocolTeamMultisigtiSig"); // Multi-sign wallet and deployer
    address protocolTeamMultisig2 = makeAddr("mulprotocolTeamMultisigtiSig2"); // Alternate Multi-sign wallet and deployer

    // liquidity Providers:
    address public LP1 = makeAddr("player");
    address public Player2 = makeAddr("Player2");
    address public player3 = makeAddr("Player3");

    address public verifer = makeAddr("ZKverifier");
}