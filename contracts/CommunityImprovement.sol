pragma solidity >=0.4.21 <0.6.0;

import "openzeppelin-solidity/contracts/access/roles/WhitelistAdminRole.sol";
import "openzeppelin-solidity/contracts/access/roles/WhitelistedRole.sol";

contract CommunityImprovement is WhitelistAdminRole, WhitelistedRole  {

	// Attributes
	enum Phase {one, two, three} // enum
	
	struct Proposal{
		string name;
		string description;
	}
	
	Proposal[] public proposals;
	
	
	// Methods
	constructor() public {
		
	}
	
	function addProposal(string memory name, string memory description) public onlyWhitelisted{
		Proposal memory newProposal = Proposal(name, description);
		proposals.push(newProposal);
	}
	
	function getProposal(uint32 index) public view returns (string memory){
		//Proposal memory newProposal = proposals[index];
		return proposals[index].name;
	}
	
	function lotteryDraft(uint32 index) public view returns (string memory){
		//Proposal memory newProposal = proposals[index];
		return proposals[index].name;
	}
	function sayHello() public view returns(uint256){
        return(now);
    }

	uint nonce; 
	uint256 randnum;

	function random() public {
    uint256 randomnumber = uint256(keccak256(abi.encodePacked(now, msg.sender, nonce))) % 100;
    randomnumber = randomnumber + 0;
    nonce++;

    randnum = randomnumber;
	}

	function getRandom() public view returns (uint256) {
		return randnum;
	}
}

