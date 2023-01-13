// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Switch {
    address owner;
    address recipient;
    uint lastAction;

    constructor(address _recipient) public payable {
      owner = msg.sender;
      recipient = _recipient;
      lastAction = block.timestamp;
    }

    function withdraw() external {
      require((block.timestamp - lastAction) >= 52 weeks);
      (bool s1, ) = recipient.call{value: address(this).balance}("");
      require(s1);
    }

    function ping() external {
      require(msg.sender == owner);
      lastAction = block.timestamp;
    }
}