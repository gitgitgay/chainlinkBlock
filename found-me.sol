//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;



// 1. 创建一个收款函数
// 2. 记录投资人并且查看
// 3. 在锁定期内，达到目标值，生产商可以提款
// 4. 在锁定期内，没有达到目标值，投资人在锁定期以后退款

contract FundMe {
    // 记录投资人
    mapping(address=>uint256) public fundersToAmount;
    // 最小值
    uint256 MINIMUN_VALUE=1*10**18;
    function fund() external payable  {
        require(msg.value>=MINIMUN_VALUE,'send more ETH');
        // 查看
        fundersToAmount[msg.sender]=msg.value;
    }
    
    
}