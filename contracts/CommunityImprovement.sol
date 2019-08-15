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
	
}