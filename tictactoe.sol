pragma solidity ^0.4.24;

contract Tictactoe{

	address public owner;
	address public challanger;
	address public opponent;
    
    
	modifier onlyOwner() {
        require(msg.sender == owner, "Only owner is allowed to call this method.");
        _;
    }


	constructor() public {
		challanger = msg.sender;	
	}

	struct Game{
		uint balance;
		uint turn;
		address opponent;
		mapping(uint => mapping(uint => uint )) board;
		bool isset;
	}

	mapping (address => Game) games;



	
    function start() 
    public 
    payable
    onlyOwner()
    {
    	Game storage g = game[msg.sender];

    	g.balance+=msg.value;
    	g.isset = true;
    	g.opponent = 0;
    } 

	function join() 
	public
	payable
	{
		Game storage g = games[owner];
		require(g.isset && g.opponent == 0 && msg.value == g.balance);
		require(msg.sender != owner);
		if(g.opponent == 0 )
		{
			g.opponent = msg.sender;
			g.balance+=msg.value;
		}
	}  


}