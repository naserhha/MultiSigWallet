// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract MultiSigWalletERC20 {
    uint256 public requiredSignatures;
    address[] public signers;
    mapping(address => bool) public isSigner;
    mapping(address => mapping(bytes32 => bool)) public confirmations;

    constructor(address[] memory _signers, uint256 _requiredSignatures) {
        require(_signers.length >= _requiredSignatures, "Invalid signer count");
        signers = _signers;
        requiredSignatures = _requiredSignatures;
        for (uint i = 0; i < _signers.length; i++) {
            isSigner[_signers[i]] = true;
        }
    }

    modifier onlySigner() {
        require(isSigner[msg.sender], "Not a signer");
        _;
    }

    function confirmTransaction(bytes32 transactionHash) public onlySigner {
        confirmations[msg.sender][transactionHash] = true;
    }

    function executeTokenTransfer(address _tokenAddress, address _to, uint256 _amount, bytes32 transactionHash) public {
        uint256 signCount = 0;
        for (uint i = 0; i < signers.length; i++) {
            if (confirmations[signers[i]][transactionHash]) {
                signCount++;
            }
        }
        require(signCount >= requiredSignatures, "Insufficient signatures");

        IERC20 token = IERC20(_tokenAddress);
        require(token.transfer(_to, _amount), "Transfer failed");
    }
}
