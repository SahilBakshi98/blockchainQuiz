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
		bool opp;
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
    	g.opp = false;
    } 

	function join() 
	public
	payable
	{
		Game storage g = games[owner];
		require(g.isset && g.opp == false && msg.value == g.balance);
		require(msg.sender != owner);
		if(g.opp == false )
		{
			g.opponent = msg.sender;
			g.balance+=msg.value;
			g.opp =true;
		}

	}  

	function playgame(uint row, uint col) 
	public
	payable
	{
		uint8 player = 2;
		if(msg.sender == owner)
			player =1;

		require(g.balance>0 && g.opp==true && row>=0 && col>=0 && row<3 && col<3 && g.board[row][col]==0  && g.turn!=player);
		g.board[row][col]=player;

		
		if(isWinner(player))
		{
			if(player==1)
			{
				owner.transfer(g.balance);
			}
			else
				g.opponent.transfer(g.balance);

			g.balance = 0;
			return;	
		}
		if(is_board_full)
		{
			owner.transfer(g.balance/2);
			g.opponent.transfer(g.balance/2);
			g.balance=0;
			return;
		}
	}

	function isWinner(uint player)
	public view 
	onlyOwner()
	returns (bool winner)
	{
		if(check(owner,player,0,1,2,0,1,2) || check(host,player,0,1,2,2,1,0))
			return true;

		for(uint i = 0;i<3;i++)
		{
			if(check(owner,player,i,i,i,0,1,2)|| check(host,player,0,1,2,i,i,i))
				return true;
		}	
	}

	function is_board_full()
	public
	{
		Game storage g = games[owner];

		uint count=0;
		for(uint i=0;i<3;i++)
		{
			for(uint j = 0;j<3;j++)
			{
				if(g.board[i][j]>0)
					count++;
			}
		}

		if(count==9)
			return true;
		else
			return false;	

	}

}