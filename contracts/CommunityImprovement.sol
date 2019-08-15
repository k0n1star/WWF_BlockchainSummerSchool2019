pragma solidity >=0.4.21 <0.6.0;


contract CommunityImprovement {
	address[] private whitelist;
	address admin ;
	enum Phase {one, two, three} // enum
	
	struct Proposal{
		string name;
		string description;
	}
	
	Proposal[] public proposals;
	
	constructor() public {
		admin = msg.sender;
	}
	
	modifier onlyAdmin() {
        if (msg.sender == admin) _;
    }
	
	modifier onlyWhitelisted() {
		// search for address in whitelist
		// if exists in whitelist _;
		_;
	}
	
	
	function givePermission(address citizen) public onlyAdmin{
		whitelist.push(citizen);
	}
	
	function getWhitelist(uint256 index) public view returns (address) {
	// Check arraybounds
		return whitelist[index];
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