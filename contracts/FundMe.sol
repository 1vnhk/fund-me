// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { PriceConverter } from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5 * (10 ** 18);

    address[] public funders;
    mapping(address funder => uint256 amount) public addressToFunded;

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send enough ETH"); // msg.value has 18 decimals
        funders.push(msg.sender);
        addressToFunded[msg.sender] += msg.value;
    }

    // 2. Withdraw funds to owner's account
    function withdraw() public {}
}
