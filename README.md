# -zk_panagram
 a word-guessing game powered by ZK-SNARKs. 

Core Game Concept:
The game revolves around "answers" (e.g., specific words), where each correct answer defines a "round."

Essentially, each "answer" corresponds to a unique "round."

Rounds are designed to be continuous. The contract owner has the exclusive ability to initiate the subsequent round.

Owner's Role and Responsibilities:

A designated smart contract owner will exist.

Crucially, only this owner is authorized to start a new round of the game.

Round Mechanics and Rules:

Minimum Duration: Each round must last for a predefined minimum duration.

Starting New Rounds: A new round can only be initiated if the preceding round has concluded with a declared winner.

Determining the Winner: The winner of a round is the first user to submit the correct guess for that round's answer.

Runners-Up: Other users who submit correct guesses after the official winner has been determined are acknowledged as "runners-up."

NFT Contract (ERC-1155 Standard):

The main Panagram smart contract will adhere to the ERC-1155 token standard. This standard is chosen for its ability to manage multiple distinct token types (semi-fungible tokens) within a single contract.

Token ID 0: This token ID will be minted and awarded to the winners of each round.

Token ID 1: This token ID will be minted and awarded to the runners-up in each round.

Token Minting Logic:

Token ID 0 (Winner's Token) is exclusively minted to the user who is the first to submit a correct guess in a given round.

Token ID 1 (Runner-Up Token) is minted to users who submit a correct guess but are not the first to do so in that round.

Verifier Smart Contract Integration:

To ascertain the correctness of a user's submitted guess, the Panagram contract will delegate this task by calling a separate, specialized "Verifier smart contract."

The blockchain address of this Verifier contract will be a required parameter, passed into the Panagram contract's constructor during deployment.


olahamid@DESKTOP-HVIMKBE:~/ZK/zk_panagram$ npm install @noir-lang/noir_js@1.0.0-beta.6 @aztec/bb.js@0.84.0

added 12 packages in 18s
olahamid@DESKTOP-HVIMKBE:~/ZK/zk_panagram$ npm install ethers

added 9 packages, and audited 22 packages in 7s

3 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
olahamid@DESKTOP-HVIMKBE:~/ZK/zk_panagram$ 