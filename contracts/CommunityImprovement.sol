pragma solidity >=0.4.21 <0.6.0;

import "openzeppelin-solidity/contracts/access/roles/WhitelistAdminRole.sol";
import "openzeppelin-solidity/contracts/access/roles/WhitelistedRole.sol";

contract CommunityImprovement is WhitelistAdminRole, WhitelistedRole  {

	// Attributes
	bool lotteryActive;
	uint256 lotteryDraftEarliestExecution;
	uint256 lotteryDraftLatestExecution;
	uint nonce; 
	uint256 randnum;
	address[] whitelist;
	address lotteryWinner;
	
	bool communitySizeSet;
	uint256 communitySize;
	uint256 numberOfWhitelisted;
	enum Phase {one, two, three} // enum
	
	struct Proposal{
		string name;
		string description;
	}
	
	Proposal[] public proposals;
	
	
	// Methods
	constructor() public {
		lotteryActive = false;
		numberOfWhitelisted = 0;
		communitySizeSet = false;
	}
	
	function addProposal(string memory name, string memory description) public onlyWhitelisted{
		Proposal memory newProposal = Proposal(name, description);
		proposals.push(newProposal);
	}
	
	function getProposal(uint32 index) public view returns (string memory){
		//Proposal memory newProposal = proposals[index];
		return proposals[index].name;
	}
	
	function addWhitelisted(address account) public onlyWhitelistAdmin {
        super.addWhitelisted(account);
		whitelist.push(account);
		numberOfWhitelisted++;
    }
	
	function setCommunitySize(uint256 size) public onlyWhitelistAdmin returns (bool) {
		if (!communitySizeSet){
			communitySizeSet = true;
			communitySize = size;
			return true;
		}
		return false;
	}
	
	function getNumberOfWhitelisted() public view returns (uint256) {
		return numberOfWhitelisted;
	}
	
	// this function should probably be combined with uploading the funds for the lottery
	function setLotteryTimeframe(uint256 start, uint256 end) public onlyWhitelistAdmin returns (bool){
		if (!lotteryActive){
			lotteryDraftEarliestExecution = start;
			lotteryDraftLatestExecution = end;
			lotteryActive = true;
			return true;
		}
		return false;
	}
	
	function currentTime() public view returns (uint256){
		return now;
	}
	
	function lotteryDraft () public onlyWhitelistAdmin returns (bool){
		if (lotteryActive && now > lotteryDraftEarliestExecution && numberOfWhitelisted > (communitySize/2) ){
			random(0,numberOfWhitelisted);
			lotteryWinner = whitelist[randnum];
			return true;
		}else{
			return false;
		}
	}
	
	function winner () public view returns (address){
		return lotteryWinner;
	}
	
	function random(uint256 lowerBound, uint256 upperBound) public returns (uint256){
		uint256 randomnumber = uint256(keccak256(abi.encodePacked(now, msg.sender, nonce))) % (upperBound - lowerBound);
		randomnumber = randomnumber + lowerBound;
		nonce++;
		randnum =  randomnumber;
	}

	function getRandom() public view returns (uint256) {
		return randnum;
	}
}

