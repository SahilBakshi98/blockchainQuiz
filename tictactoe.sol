pragma solidity ^0.4.24;

contract Tictactoe{

	address public owner;
    
    uint playercount;
	

	constructor() public {
		playercount=0;
	}

	struct Game{
		uint balance;
		uint turn;
		address opponent;
		mapping(uint => mapping(uint => uint )) board;
	}

	modifier onlyOwner() {
        require(msg.sender == owner, "Only owner is allowed to call this method.");
        _;
    }

	function addPlayer(){

	}  


}