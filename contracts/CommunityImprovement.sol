pragma solidity >=0.4.21 <0.6.0;

import "openzeppelin-solidity/contracts/access/roles/WhitelistAdminRole.sol";
import "openzeppelin-solidity/contracts/access/roles/WhitelistedRole.sol";

contract CommunityImprovement is WhitelistAdminRole, WhitelistedRole  {

	// Attributes
	bool lotteryActive;
	uint256 lotteryDraftEarliestExecution;
	uint256 lotteryDraftLatestExecution;
	
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
	
<<<<<<< HEAD
	function addWhitelisted(address account) public onlyWhitelistAdmin {
        super.addWhitelisted(account);
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
	
	function lotteryDraft () public view onlyWhitelistAdmin returns (string memory){
		if (lotteryActive && now > lotteryDraftEarliestExecution && numberOfWhitelisted > (communitySize/2) ){
			return 'Lottery can be drafted';
		}else{
			return 'lottery draft is not possible';
		}
	}
	
	
}
=======
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

>>>>>>> 6f96adc74cb425e55073f43f9937e0dc192ee271
