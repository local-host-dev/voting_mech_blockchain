// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract voter_contract {
    using Counters for Counters.Counter;

    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier _ownerOnly() {
        require(msg.sender == owner);
        _;
    }

    //Counters, keeping tab of the total number of candidates and voters
    Counters.Counter private candidate_num;
    Counters.Counter private voter_num;

    //-----------------------------------------------------------------------------------------------------------------------------------------
    //A mapping of all the candidates
    mapping(uint256 => Candidate) private idCandidate;

    struct Candidate {
        uint256 candidateId;
        string name;
        bool auth;
        uint256 num_votes;
        string party;
    }

    event eventCandidate(
        uint256 candidateId,
        string name,
        bool auth,
        uint256 num_votes,
        string party
    );

    //-----------------------------------------------------------------------------------------------------------------------------------------
    //A mapping of all the voters
    mapping(address => Voter) private idVoter;

    struct Voter {
        uint256 voterId;
        string name;
        bool auth;
        bool voted;
        uint256 vote;
    }

    event eventVoter(
        uint256 voterId,
        string name,
        bool auth,
        bool voted,
        uint256 vote
    );

    //Add a voter based on their wallet address
    function addVoter(
        address _voter,
        uint256 _voterId,
        string memory _name
    ) public {
        voter_num.increment();
        idVoter[_voter] = Voter(_voterId, _name, false, false, 0);

        emit eventVoter(_voterId, _name, false, false, 0);
    }

    //Add a candidate, assigning them a unique id
    function addCandidate(
        string memory _name,
        string memory _party
    ) public _ownerOnly {
        candidate_num.increment();
        uint256 num = candidate_num.current();
        idCandidate[num] = Candidate(num, _name, false, 0, _party);

        emit eventCandidate(num, _name, false, 0, _party);
    }

    //Authorizing a voter (Can only be done by the contract owner)
    function authVoter(address _voter, bool _auth) public _ownerOnly {
        require(idVoter[_voter].voterId != 0, "Voter does not exist.");
        idVoter[_voter].auth = _auth;
    }

    //Authorizing a candidate (Can only be done by the contract owner)
    function authCandidate(uint256 _id, bool _auth) public _ownerOnly {
        require(idCandidate[_id].candidateId != 0, "Candidate does not exist.");
        idCandidate[_id].auth = _auth;
    }

    //-----------------------------------------------------------------------------------------------------------------------------------------

    //Voting for a candidate
    function vote(address _voter, uint256 _candidateId) public {
        require(idVoter[_voter].voted == false, "You have already voted once.");
        idVoter[_voter].vote = _candidateId;
        idVoter[_voter].voted = true;
        idCandidate[_candidateId].num_votes++;
    }
}
