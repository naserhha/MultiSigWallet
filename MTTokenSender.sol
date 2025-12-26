// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract MTTokenSender {
    address public owner;

    // Modifier برای اطمینان از اینکه تنها مالک قادر به ارسال توکن‌ها است
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can send tokens");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // تابع ارسال توکن
    function sendTokens(address _tokenAddress, address _to, uint256 _amount) public onlyOwner returns (bool) {
        IERC20 token = IERC20(_tokenAddress);
        require(token.transfer(_to, _amount), "Transfer failed");
        return true;
    }
}
