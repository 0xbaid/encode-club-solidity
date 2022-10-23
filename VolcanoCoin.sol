//SPDX-License-Identifier: MIT

//Homework 4

pragma solidity ^0.8.0;

contract VolcanoCoin {
    event SupplyIncreased(uint indexed _value);
    event Transfer(uint indexed _amount, address indexed _to);

    uint256 totalSupply = 1000 * 10 ** 18;
    address owner;
    mapping(address => uint256) public balances;
    

    struct Payment {
        uint256 amount;
        address to;
    }

    mapping(address => Payment[]) public payments;

    modifier onlyOwner {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
        balances[msg.sender] = totalSupply;
    }


    function maxTotalSupply() public view returns(uint256) {
        return totalSupply;
    }

    function increaseTotalSupply() public onlyOwner {
        totalSupply = totalSupply + 1000 * 10 ** 18;
        emit SupplyIncreased(totalSupply);
    }

    function transfer(uint256 _amount, address _to) payable public {
        totalSupply = maxTotalSupply() - _amount;
        Payment[] storage payment = payments[_to];
        payment.push(Payment({amount: _amount, to: _to}));
        balances[_to] = _amount;
        emit Transfer(_amount, _to);
    }
}
