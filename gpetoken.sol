// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7 ;

import "./IERC20.sol";

contract GPEToken is IERC20{

    string public name = "Glory Praise Emmanuel Token";
    string public symbol = "GPE";
    uint public decimals = 18;
    uint public override totalSupply = 1000000;

    constructor(){
        balanceOf[msg.sender] = totalSupply;
    }

    mapping(address => uint256) public override balanceOf;
    mapping(address => mapping(address => uint256)) approved;

    function transfer(address _to, uint256 _amount) public override returns(bool){
        balanceOf[msg.sender] -= _amount;
        balanceOf[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }

    function allowance(address _owner, address _spender) public view override returns(uint256){
        uint256 _amount = approved[_owner][_spender];
        return _amount;
    }

    function approve(address _spender, uint256 _amount) public override returns(bool){
        require(balanceOf[msg.sender] >= _amount, "You don't have enough tokens for this transaction!");
        approved[msg.sender][_spender] += _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _amount) public override returns(bool){
        require(approved[_from][msg.sender] >= _amount, "Token amount not approved ");
        approved[_from][msg.sender] -= _amount;
        balanceOf[_from] -= _amount;
        balanceOf[_to] += _amount;
        emit Transfer(_from, _to, _amount);
        return true;
    }

    function deposit(address _from, address _to, uint256 _amount) public override returns(bool) {
        require(balanceOf[msg.sender] >= _amount, "You dont have enough token to send");
        balanceOf[_from] -= _amount;
        balanceOf[_to] += _amount;
        
        emit Transfer(_from, _to, _amount);
        return true;
    }

}