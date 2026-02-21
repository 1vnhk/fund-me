// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract FundMe {
    uint256 public minimumUSD = 5;

    function fund() public payable {
        // Get funds from users
        // Set a minimum funding value in USD
        require(msg.value >= minimumUSD, "didn't send enough ETH");
    }

    // 2. Withdraw funds to owner's account
    function withdraw() public {}
}
