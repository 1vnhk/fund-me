// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract FundMe {
    function fund() public payable {
        // Get funds from users
        // Set a minimum funding value in USD

        require(msg.value > 1 ether, "didn't send enough ETH");
    }

    // 2. Withdraw funds to owner's account
    function withdraw() public {}

    function tinyTip() public payable {
        require(msg.value < 1 gwei, "Please, send less than 1 Gwei");
    }
}
