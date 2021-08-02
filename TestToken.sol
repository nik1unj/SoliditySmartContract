pragma solidity ^0.8.4;

contract TestToken{
    
    string public symbol ="NSR";
    string public name ="MYTOKEN";
    uint256 public totalSupply;
    address public admin=msg.sender;
    
    
    mapping(address => uint ) public balances;
    mapping(address => mapping(address => uint)) allowance;
    
    event Transfer(address _from, address _to,uint _value);
    
    event Approval(address _owner,address _spender, uint _amount);
    

    
    
    function myToken(uint  _initialSupply) public{
        balances[msg.sender]= _initialSupply;
        totalSupply = _initialSupply;
    }
    
    
    //Transfer function
    
    function transfer(address _to, uint _value) public returns(bool success) {
        require(balances[msg.sender]>=_value,'Not enough balance in account');
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender,_to,_value);
        return true;
    }
    
    function approve(address _spender, uint _amount) public{
        allowance[msg.sender][_spender]=_amount;
        emit Approval(msg.sender,_spender,_amount);
    }
    
    
    function transferFrom(address _from,address _to, uint _value) public returns(bool success){
        require(_value <= balances[_from],'Not enough balance in account');
        require(_value<=allowance[_from][msg.sender],'cannot spend more than approval');
        balances[_from] -= _value;
        balances[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from,_to, _value);
        return true;
        
        
    }
    
    
}