import {ERC1155} from "../lib/openzeppelin-contracts/contracts/token/ERC1155/ERC1155.sol";
import {IVerifier} from "./verifier.sol";

contract Paragram is ERC1155 {

    IVerifier public immutable iVerifier;

    constructor(IVerifier _verifier) ERC1155("") {
        iVerifier = _verifier;
    }
}