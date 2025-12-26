// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract MultiSigWallet {
    address[] public owners;
    mapping(address => bool) public isOwner;
    uint256 public requiredSignatures;
    uint256 public transactionCount;

    struct Transaction {
        address to;
        uint256 value;
        bytes data;
        uint256 confirmations;
        bool executed;
    }

    mapping(uint256 => Transaction) public transactions;
    mapping(uint256 => mapping(address => bool)) public confirmations;

    // Token management
    mapping(address => bool) public supportedTokens;
    mapping(address => uint256) public tokenBalances;

    // Events
    event TransactionSubmitted(uint256 transactionId, address indexed owner);
    event TransactionConfirmed(uint256 transactionId, address indexed owner);
    event TransactionExecuted(uint256 transactionId);
    event TransactionRevoked(uint256 transactionId, address indexed owner);

    event TokenContractAdded(address indexed tokenAddress);
    event TokenContractRemoved(address indexed tokenAddress);
    event TokensTransferred(address indexed tokenAddress, address indexed from, address indexed to, uint256 amount);

    // Modifier to restrict to only owners
    modifier onlyOwner() {
        require(isOwner[msg.sender], "Not an owner");
        _;
    }

    // Modifier to ensure that the transaction exists
    modifier transactionExists(uint256 _transactionId) {
        require(_transactionId < transactionCount, "Transaction does not exist");
        _;
    }

    // Constructor to initialize the contract
    constructor(address[] memory _owners, uint256 _requiredSignatures) {
        require(_owners.length > 0, "Owners required");
        require(_requiredSignatures <= _owners.length, "Invalid required signatures");

        for (uint i = 0; i < _owners.length; i++) {
            isOwner[_owners[i]] = true;
        }
        owners = _owners;
        requiredSignatures = _requiredSignatures;
    }

    // Submit a transaction for approval
    function submitTransaction(address _to, uint256 _value, bytes memory _data) public onlyOwner {
        uint256 transactionId = transactionCount++;
        transactions[transactionId] = Transaction({
            to: _to,
            value: _value,
            data: _data,
            confirmations: 0,
            executed: false
        });
        emit TransactionSubmitted(transactionId, msg.sender);
    }

    // Confirm a transaction
    function confirmTransaction(uint256 _transactionId) public onlyOwner transactionExists(_transactionId) {
        require(!confirmations[_transactionId][msg.sender], "Transaction already confirmed");
        require(!transactions[_transactionId].executed, "Transaction already executed");

        confirmations[_transactionId][msg.sender] = true;
        transactions[_transactionId].confirmations++;

        emit TransactionConfirmed(_transactionId, msg.sender);

        executeTransaction(_transactionId);
    }

    // Revoke confirmation for a transaction
    function revokeConfirmation(uint256 _transactionId) public onlyOwner transactionExists(_transactionId) {
        require(confirmations[_transactionId][msg.sender], "Transaction not confirmed");
        require(!transactions[_transactionId].executed, "Transaction already executed");

        confirmations[_transactionId][msg.sender] = false;
        transactions[_transactionId].confirmations--;

        emit TransactionRevoked(_transactionId, msg.sender);
    }

    // Execute a confirmed transaction
    function executeTransaction(uint256 _transactionId) public transactionExists(_transactionId) {
        Transaction storage txn = transactions[_transactionId];

        require(txn.confirmations >= requiredSignatures, "Not enough confirmations");
        require(!txn.executed, "Transaction already executed");

        txn.executed = true;
        (bool success, ) = txn.to.call{value: txn.value}(txn.data);
        require(success, "Transaction failed");

        emit TransactionExecuted(_transactionId);
    }

    // Add a new ERC20 token contract
    function addTokenContract(address _tokenAddress) public onlyOwner {
        require(_tokenAddress != address(0), "Invalid address");
        supportedTokens[_tokenAddress] = true;
        emit TokenContractAdded(_tokenAddress);
    }

    // Remove an ERC20 token contract
    function removeTokenContract(address _tokenAddress) public onlyOwner {
        require(supportedTokens[_tokenAddress], "Token not supported");
        supportedTokens[_tokenAddress] = false;
        emit TokenContractRemoved(_tokenAddress);
    }

    // Transfer tokens from the wallet
    function transferTokens(address _tokenAddress, address _to, uint256 _amount) public onlyOwner {
        require(supportedTokens[_tokenAddress], "Token not supported");
        IERC20 token = IERC20(_tokenAddress);
        require(token.transfer(_to, _amount), "Transfer failed");

        tokenBalances[_tokenAddress] -= _amount;
        emit TokensTransferred(_tokenAddress, msg.sender, _to, _amount);
    }

    // Get the token balance of the wallet
    function getTokenBalance(address _tokenAddress) public view returns (uint256) {
        return tokenBalances[_tokenAddress];
    }

    // Fallback function to accept ether deposits
    receive() external payable {}
}
