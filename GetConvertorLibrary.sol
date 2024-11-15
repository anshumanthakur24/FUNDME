// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library priceConvertor{
    function getValue() internal  view returns(uint256){
        AggregatorV3Interface priceFeed=AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,)=priceFeed.latestRoundData();
        return uint256(price * 1e10);
        }
    function getConver(uint256 eht) internal view returns(uint256){
        return ((eht * getValue())/1e18);
    }
}