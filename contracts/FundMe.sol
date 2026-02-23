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

    function withdraw() public {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToFunded[funder] = 0;
        }

        funders = new address[](0); // reset funders
        
        // withdraw funds
        // payable(msg.sender).transfer(address(this).balance); -- using transfer
        // bool sendSuccess = payable(msg.sender).send(address(this).balance); -- using send
        // require(sendSuccess, "Send failed");

        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }
}
