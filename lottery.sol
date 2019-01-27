pragma solidity ^0.4.25;

contract RandomLottery {
    
    address owner;
    address[] participants;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function participat() public payable returns(bool){
        if(msg.value <=1){
            return false;
        }
        else {
            participants.push(msg.sender);
        }
    }
    
    function getParticipants() public view returns(address[]){
        return participants;
    }
    
    modifier onlyowner(){
        require(msg.sender == owner);
            _;
        
    }
    
    function random() private view returns(uint){
        return uint(keccak256(abi.encode(block.difficulty, now, participants)));
    }
   
   
   function winner() public onlyowner{
       uint index = random() % participants.length;
       participants[index].transfer(address(this).balance);
       participants =new address[](0);
   }
}