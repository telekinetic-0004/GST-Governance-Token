# GirlScriptToken (GST) Contract

### `This Solidity smart contract implements the GirlScriptToken (GST), an ERC-20 governance token with features like pausability, access control, voting on proposals, and permit functionality.`

## Existence on the sepolia testnet

 - [Contract Creation Proof](https://sepolia.etherscan.io/token/0x110Aa39698DFeee9B894AEe808929B87838e7174)
 - [Transaction Details](https://sepolia.etherscan.io/tx/0x2e34530d0a9da61efa335e987bcaad596c9304e887a5246dc98d94beb3bcd799)
 - [Block Creation Details](https://sepolia.etherscan.io/block/5202308)

## Features

- ERC-20 Token: Implements the basic ERC-20 token standards.
- Pausable: Can be paused and unpaused by designated administrators.
- Access Control: Uses OpenZeppelin's AccessControl to manage roles such as pauser and minter.
- Permit Functionality: Implements ERC-20 permit for gasless transactions.
- Voting System: Allows token holders to create and vote on proposals.

## Contract Structure

- `GST.sol`: The main contract file containing the implementation.
- `@openzeppelin/contracts`: External dependencies from OpenZeppelin.

## Roles

- `DEFAULT_ADMIN_ROLE`: has special permissions, such as granting and revoking roles.
- `PAUSER_ROLE`: Allows an address to pause and unpause the contract.
- `MINTER_ROLE`: Allows an address to mint new tokens.

## Events

- `Voted`: Triggered when a token holder casts a vote on a proposal.
- `ProposalCreated`: Triggered when a new proposal is created.
- `ProposalExecuted`: Triggered when a proposal is executed.

## Proposals

- Proposals are created with a description and are voted on by token holders.
- Each proposal tracks the number of votes in favor and against.

## Functions

#### Pausable Functions

`pause()` - Pauses the contract, preventing token transfers.

`unpause()` - Unpauses the contract, allowing token transfers.

#### Mintable Functions

`mint(address to, uint256 amount)` - Mints new tokens for the specified address.

#### Governance Functions

`createProposal(string memory description)` - Creates a new proposal with the specified description.

`vote(uint256 proposalId, bool inSupport)` - Casts a vote on the specified proposal, either in favor or against it.

## Security
#### `The contract uses OpenZeppelin's proven and audited library of smart contract components, which significantly reduces the risk of security vulnerabilities. However, it is still essential to follow best practices when deploying and using the contract, such as:`

- `Using a secure and hardened environment for contract deployment.`
- `Using multi-signature wallets or time-locks for managing contract ownership.`
- `Regularly monitoring the contract for any unusual activity.`

## Usage

```solidity
// Deploy the GST contract with initial roles
GST gst = new GST(defaultAdmin, pauser, minter);

// Mint new tokens (requires MINTER_ROLE)
gst.mint(addressToMint, amountToMint);

// Create a new proposal (requires positive token balance)
gst.createProposal("Implement feature X");

// Vote on a proposal
gst.vote(proposalId, true);
```
