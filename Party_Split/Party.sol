// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

  contract Party{

    uint256 rsvp_deposit;
    address[] members;
    mapping(address => bool) paid;

  constructor(uint _deposit) {
    //New members must pay the deposit amount
    rsvp_deposit = _deposit;
  }

//members joining the party
  function rsvp() external payable {
    //Make sure user has paid
    require(!paid[msg.sender]);
    require(msg.value == rsvp_deposit);
    members.push(msg.sender);
    paid[msg.sender] = true;
  }

  function payBill(address _venue, uint _amount) external {
  //pay the bill
   ( bool success1, ) = _venue.call{value: _amount}("");
   require(success1);

  //send the remainder of funds evenly to members
    uint share = address(this).balance / members.length;
    for (uint i; i < members.length; i++) {
      ( bool success2, ) = members[i].call{value: share}("");
      require(success2);
    }
  }
	
}