//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//  复制于https://docs.chain.link/data-feeds/getting-started
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// 1. 创建一个收款函数
// 2. 记录投资人并且查看
// 3. 在锁定期内，达到目标值，生产商可以提款
// 4. 在锁定期内，没有达到目标值，投资人在锁定期以后退款

contract FundMe {
    // 记录投资人
    mapping(address=>uint256) public fundersToAmount;
    // 最小值
    uint256 MINIMUN_VALUE=100*10**18;
    // 预言机=
    // 合约类型
    AggregatorV3Interface internal dataFeed;

    constructor() {
        dataFeed=AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }
    function fund() external payable  {
        require(msg.value>=MINIMUN_VALUE,'send more ETH');
        // 查看
        fundersToAmount[msg.sender]=msg.value;
    } 
    
    // 复制于https://docs.chain.link/data-feeds/getting-started
    function getChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundId */,
            int256 answer,
            /*uint256 startedAt*/,
            /*uint256 updatedAt*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }
    // Eth转USD
    function EthToUsd(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice=uint256(getChainlinkDataFeedLatestAnswer());
        return ethAmount*ethPrice/10**8;
    }
}