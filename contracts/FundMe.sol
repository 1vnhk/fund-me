// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public constant MINIMUM_USD = 5 * (10 ** 18);

    function fund() public payable returns (uint256) {
        // Get funds from users
        // Set a minimum funding value in USD
        require(getConversionRate(msg.value) >= MINIMUM_USD, "didn't send enough ETH"); // msg.value has 18 decimals
    }

    function getPrice() public view returns (uint256) {
        // Address of the oracle ETH/USD on Sepolia: 0x694AA1769357215DE4FAC081bf1f309aDC325306 -- Chainlink
        // ABI

        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price) * (10 ** (18 - priceFeed.decimals()));
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) * (10 ** 18);

        return ethAmountInUsd;
    }

    // 2. Withdraw funds to owner's account
    function withdraw() public {}
}
