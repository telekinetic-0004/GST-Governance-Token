// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

/// @custom:security-contact JAYMIN
contract GST is ERC20, ERC20Pausable, AccessControl, ERC20Permit, ERC20Votes {
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    // A mapping to track if an address has already voted
    mapping(address => bool) public hasVoted;

    // The structure for a proposal
    struct Proposal {
        address proposer;      // The proposer's address
        string description;   // The proposal's description
        uint256 votesFor;     // Number of votes in favor
        uint256 votesAgainst; // Number of votes against
        bool executed;        // Whether the proposal has been executed
    }

    // Array to store all proposals
    Proposal[] public proposals;

    // Event for when an address votes
    event Voted(address indexed voter, bool inSupport);
    // Event for when a proposal is created
    event ProposalCreated(address indexed proposer, string description);
    // Event for when a proposal is executed
    event ProposalExecuted(uint256 indexed proposalId);

    constructor(address defaultAdmin, address pauser, address minter)
        ERC20("GirlScriptToken", "GST")
        ERC20Permit("GirlScriptToken")
    {
        _mint(msg.sender, 694200000000000000); // Set an initial total supply and assign all initial tokens to the owner
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _grantRole(PAUSER_ROLE, pauser);
        _grantRole(MINTER_ROLE, minter);
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    // Function to create a new proposal
    function createProposal(string memory description) external {
        require(balanceOf(msg.sender) > 0, "Not enough tokens to create a proposal");

        proposals.push(Proposal({
            proposer: msg.sender,
            description: description,
            votesFor: 0,
            votesAgainst: 0,
            executed: false
        }));

        emit ProposalCreated(msg.sender, description);
    }

    // Function to cast a vote on a proposal
    function vote(uint256 proposalId, bool inSupport) external {
        require(!hasVoted[msg.sender], "Already voted");
        require(proposalId < proposals.length, "Invalid proposalId");

        hasVoted[msg.sender] = true;
        Proposal storage proposal = proposals[proposalId];

        if (inSupport) {
            proposal.votesFor += balanceOf(msg.sender);
        } else {
            proposal.votesAgainst += balanceOf(msg.sender);
        }

        emit Voted(msg.sender, inSupport);
    }

    // The following functions are overrides required by Solidity.

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Pausable, ERC20Votes)
    {
        super._update(from, to, value);
    }

    function nonces(address owner)
        public
        view
        override(ERC20Permit, Nonces)
        returns (uint256)
    {
        return super.nonces(owner);
    }
}
