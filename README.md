# Smart Contract for a Multi-Signature Wallet & Token Wallet

## Overview

This smart contract program defines a multi-signature wallet that requires multiple signatures to access the funds. It can be used as a secure way to manage assets that require more than one person's approval for transactions.

This smart contract is designed to create a wallet for storing ERC20 tokens. It allows users to add new tokens to their wallet, view their token balances, and transfer tokens to other addresses.

The contract utilizes the OpenZeppelin library for ERC20 token functionality, ensuring compatibility with the ERC20 standard and providing robust, tested code for secure token transfers.

## Implementation

The smart contract is written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain. It defines a contract called `MultiSigWallet` with the following features:

- **constructor(uint _required, address[] memory _owners)**: Initializes the contract with the required number of signatures (`_required`) and the addresses of the wallet owners (`_owners`).
- **receive()**: A special function to accept Ether deposits.
- **submitTransaction(address payable _to, uint _value, bytes memory _data)**: Creates a new transaction with the specified parameters and returns the transaction ID.
- **confirmTransaction(uint _transactionId)**: Confirms a pending transaction.
- **revokeConfirmation(uint _transactionId)**: Revokes a previous confirmation for a transaction.
- **executeTransaction(uint _transactionId)**: Executes a confirmed transaction if it has received enough confirmations.
- **Token Management**: The contract can add, remove, and transfer ERC20 tokens. It also allows users to approve token spending, withdraw tokens, and check token balances.

## Usage

To use this multi-signature wallet, follow these steps:

1. **Deploy the Smart Contract**: Deploy the `MultiSigWallet` contract on the Ethereum blockchain with the required number of signatures (`_required`) and the addresses of the wallet owners (`_owners`).
2. **Deposit Funds**: Deposit funds into the wallet using the `deposit()` function.
3. **Create Transactions**: Use the `submitTransaction()` function with the recipient address (`_to`), the amount of ether to send (`_value`), and the data to include with the transaction (`_data`).
4. **Confirm Transactions**: Wait for the required number of wallet owners to confirm the transaction using the `confirmTransaction()` function.
5. **Execute Transactions**: Once enough confirmations have been gathered, execute the transaction using the `executeTransaction()` function.
6. **Token Integration**:
   - Deploy the ERC20 Token contract on the Ethereum network using Remix or Truffle.
   - Add the Token contract to the wallet by calling `addTokenContract()` in the `MultiSigWallet` contract.
   - Use the `sendFunds()` function to send Ether from the wallet to a recipient.
   - Use the `transferToken()` function to transfer ERC20 tokens from the wallet to a recipient address.
   - Use the `withdrawToken()` function to withdraw tokens from the wallet to an external address.
   - Use the `getBalance()` function to check the token balance within the wallet.
   - Use the `approve()` and `transferFrom()` functions in the ERC20 contract to allow the wallet to manage token transfers on behalf of the owner.

7. **Integrate in DApp**:
   - Import the Smart Wallet and Token contract ABIs into your DApp.
   - Initialize contract instances in your DApp.
   - Use the contract instances to interact with the contracts as needed.

## Functions

### Token Management Functions

- **addTokenContract(address _tokenContractAddress)**: 
  Adds a new ERC20 token contract to the wallet. Requires the user to input the address of the token contract.
  
- **removeTokenContract(address _tokenContractAddress)**:
  Removes an existing ERC20 token contract from the wallet. Requires the user to input the address of the token contract to be removed.

- **getTokenBalance(address _tokenContractAddress, address _userAddress)**: 
  Returns the token balance of the specified user's address for the specified token contract address.

- **transferTokens(address _tokenContractAddress, address _recipientAddress, uint256 _amount)**: 
  Transfers the specified amount of tokens from the sender's address to the recipient's address.

- **approveTokens(address _tokenContractAddress, address _spenderAddress, uint256 _amount)**: 
  Allows the specified spender's address to transfer the specified amount of tokens from the sender's address.

- **transferFrom(address _tokenContractAddress, address _senderAddress, address _recipientAddress, uint256 _amount)**: 
  Transfers the specified amount of tokens from the sender's address to the recipient's address on behalf of the approved spender.

- **getContractOwner()**: 
  Returns the address of the owner of the token wallet contract.

- **isContract(address _address)**: 
  Checks if the input address is a contract address.

## Events

- **TokenContractAdded(address _tokenContractAddress, string _tokenName)**: 
  Emitted when a new ERC20 token contract is added to the wallet.
  
- **TokenContractRemoved(address _tokenContractAddress)**: 
  Emitted when an existing ERC20 token contract is removed from the wallet.
  
- **TokensTransferred(address _tokenContractAddress, address _senderAddress, address _recipientAddress, uint256 _amount)**: 
  Emitted when tokens are transferred from one address to another.

- **TokensApproved(address _tokenContractAddress, address _spenderAddress, uint256 _amount)**: 
  Emitted when tokens are approved for transfer by a spender's address.

## Benefits

This smart contract program provides several benefits:

- **Secure Multi-Signature**: It offers a secure way to manage assets that require multiple approvals for transactions.
- **Decentralization**: It is decentralized, meaning that there is no need for a trusted third party to manage the wallet.
- **Transparency & Immutability**: All transactions and confirmations are recorded on the Ethereum blockchain, ensuring transparency and immutability.
- **Programmable**: It allows automatic execution of transactions, reducing the need for manual intervention.

The last benefit is particularly useful in cases where multiple transactions need to be executed automatically, such as payroll management in a business. The contract can be programmed to execute salary payments on a specific day each month, improving efficiency and reducing errors.

## Conclusion

In conclusion, the Smart Wallet and Token contracts provide a secure and efficient way to manage Ether and tokens on the Ethereum network. By deploying and using these contracts, users can enjoy the benefits of a decentralized financial system that is transparent, secure, and accessible to all.

This smart contract program provides a powerful tool for managing assets securely and programmatically on the Ethereum blockchain.

## 📜 License

This project is licensed under a **Custom NonCommercial Attribution License**.

- ✅ Free to use, modify, and share for **non-commercial** and **educational** purposes
- ❌ **Commercial use, resale, or monetization** is strictly prohibited without prior written consent
- 📛 Attribution required: Developed by Mohammad Nasser Haji Hashemabad (https://mohammadnasser.com)

📬 For commercial licensing or inquiries: [info@mohammadnasser.com](mailto:info@mohammadnasser.com)
