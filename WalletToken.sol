// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract WalletToken is IERC20 {
    string public name = "WalletToken";
    string public symbol = "WTK";
    uint8 public decimals = 18;
    uint256 public override totalSupply;
    
    // Mapping for balances and allowances
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    // Mapping for blocked addresses (for extra security)
    mapping(address => bool) public isBlocked;

    // Event for minting
    event Mint(address indexed to, uint256 amount);

    // Only owner modifier to restrict some actions
    address public owner;
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor(uint256 _initialSupply) {
        owner = msg.sender;
        totalSupply = _initialSupply * 10 ** uint256(decimals);
        balanceOf[msg.sender] = totalSupply; // Allocate initial supply to the contract creator
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    // Transfer function to send tokens to another address
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(!isBlocked[msg.sender], "Sender is blocked");
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");

        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // Approve function to allow another address to spend tokens on behalf of the sender
    function approve(address spender, uint256 amount) public override returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // TransferFrom function to allow transfers from one address to another using an approved spender
    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(!isBlocked[sender], "Sender is blocked");
        require(balanceOf[sender] >= amount, "Insufficient balance");
        require(allowance[sender][msg.sender] >= amount, "Allowance exceeded");

        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        allowance[sender][msg.sender] -= amount;

        emit Transfer(sender, recipient, amount);
        return true;
    }

    // Mint function to create new tokens, can only be called by the owner
    function mint(address to, uint256 amount) public onlyOwner {
        totalSupply += amount;
        balanceOf[to] += amount;
        emit Mint(to, amount);
        emit Transfer(address(0), to, amount);
    }

    // Block function to prevent an address from sending tokens (for security or management purposes)
    function blockAddress(address _address) public onlyOwner {
        isBlocked[_address] = true;
    }

    // Unblock function to allow an address to send tokens again
    function unblockAddress(address _address) public onlyOwner {
        isBlocked[_address] = false;
    }
}
