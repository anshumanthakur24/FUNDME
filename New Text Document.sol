// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {priceConvertor} from "./GetConvertorLibrary.sol";

error notOwner();

contract FundMe{
    address public immutable i_owner;
    constructor(){
        i_owner=msg.sender;
    }
    using priceConvertor for uint256;
    address[] public funders;
    mapping(address=>uint256) public addressToFundAmount;
    function fund() public payable {
        //require(msg.value.getConver()>0,"You cannot pay less than 1 ether");
        if(msg.value.getConver()<5){
            revert notOwner();
        }
        funders.push(msg.sender);
        addressToFundAmount[msg.sender]=msg.value;
    }
    function Withraw() public Onlyowner {
        for(uint256 funderIndex; funderIndex<funders.length;funderIndex++){
            address funder=funders[funderIndex];
            addressToFundAmount[funder]=0;
        }
        funders=new address[](0);
        (bool calSucess,)=payable(msg.sender).call{value: address(this).balance}("");
        require(calSucess,"Transaction Failed");
    }
    modifier Onlyowner{
        require(i_owner==msg.sender,"Not the Owner");
        _;
    }
    receive() external payable {
        fund();
    }
    fallback() external payable {
        fund();
    }
    
}