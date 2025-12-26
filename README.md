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
# New Release: Multi-Signature Wallet & Token Wallet with ERC-20 Token Support

We are excited to announce a new release that significantly improves the **Multi-Signature Wallet** and **Token Wallet** smart contract suite. This release includes the integration of ERC-20 token management, enhanced security features, and added functionalities for managing and transferring tokens securely.

## What's New:
### 1. **ERC-20 Token Management**:
- The contract now fully supports the integration of **ERC-20 tokens**. You can add, remove, and manage tokens within the multi-signature wallet.
- New functions such as `addTokenContract`, `removeTokenContract`, `transferTokens`, `approveTokens`, and `transferFrom` enable seamless interaction with ERC-20 tokens directly within the multi-signature wallet.

### 2. **Multi-Signature Approval System**:
- A robust multi-signature approval system has been implemented to require multiple confirmations from owners before executing transactions. This ensures high security and prevents unauthorized access.
- New functions like `submitTransaction`, `confirmTransaction`, `revokeConfirmation`, and `executeTransaction` help facilitate multi-signature transactions securely.

### 3. **Enhanced Transaction History**:
- A dynamic transaction history is now maintained, providing complete transparency for all deposits, withdrawals, and transfers, including ERC-20 token transfers.
- This feature allows you to keep track of your wallet's activities and gives you the ability to monitor every token transfer in the system.

### 4. **Improved User Interaction**:
- **User-friendly interfaces** for **depositing** and **withdrawing** ERC-20 tokens have been added, making it easier for users to interact with the wallet and perform token-related operations.
- Forms for depositing and withdrawing tokens now allow users to specify the recipient’s address and the amount in a simple and intuitive way.

### 5. **Security Enhancements**:
- We have added a **block address feature** that allows the wallet owner to block certain addresses from performing transactions. This provides an additional layer of security against unauthorized transactions.
- The new **revokeConfirmation** function allows owners to retract their approval for transactions, giving them full control over pending transactions.

### 6. **Web3 Integration**:
- The wallet now integrates with Web3.js for browser-based interactions, enabling users to interact with their wallet via MetaMask or any other compatible Ethereum browser wallet.
- All interactions, including token transfers, are securely executed using **Ethereum’s blockchain**, ensuring the safety and immutability of your transactions.

### 7. **Deployment and Use in DApps**:
- This release includes detailed instructions on how to deploy the **Multi-Signature Wallet** and **ERC-20 Token Contracts** on the Ethereum network using **Remix** or **Truffle**.
- Developers can easily integrate the **Multi-Signature Wallet** and **ERC-20 Token Contracts** into their **DApps** by importing the contract ABIs and initializing contract instances via Web3.js.

### 8. **PHP Integration**:
- A new PHP integration allows for server-side communication with the Ethereum blockchain, enabling automated interactions with the wallet via PHP. This feature supports sending and receiving tokens, managing multi-signature transactions, and updating the transaction history in real-time.
- The **PHP_ConnectionFunction.php** now includes updated functions to interact with both **MyTokenSender** and **MultiSigWallet** contracts.

## Key Features in This Release:
- **Add and manage multiple ERC-20 tokens** in a multi-signature wallet.
- **Support for token transfers** and **approval management** using standard ERC-20 functions (`approve`, `transferFrom`, etc.).
- **Multi-signature functionality** to ensure secure, multi-approval transactions.
- **Security features**, including blocking specific addresses and the ability to revoke transaction confirmations.
- **Transaction history tracking** for deposits, withdrawals, and token transfers.
- **Web3.js** integration for seamless interaction with Ethereum.
- **PHP server-side support** for managing wallet transactions programmatically.

## How to Use:
1. **Deploy the Smart Contracts**:
   - Deploy the **Multi-Signature Wallet** contract and **ERC-20 Token** contract using **Remix** or **Truffle** on the Ethereum network (Rinkeby for testing, Mainnet for production).
   
2. **Add ERC-20 Tokens to Wallet**:
   - Use the `addTokenContract` function to add the ERC-20 token contracts to the wallet, enabling token management inside the multi-signature wallet.

3. **Create and Confirm Transactions**:
   - Submit transactions with `submitTransaction`, confirm them with `confirmTransaction`, and execute the transaction once the required number of confirmations are reached using `executeTransaction`.

4. **Manage Token Transfers**:
   - Deposit and withdraw tokens using the `transferTokens` function and approve tokens for transfer via `approveTokens`.

5. **PHP Integration**:
   - Use the **PHP_ConnectionFunction.php** for server-side interactions with the smart contracts. This allows automated deposit and withdrawal actions as well as transaction history tracking.

## Conclusion

In conclusion, the Smart Wallet and Token contracts provide a secure and efficient way to manage Ether and tokens on the Ethereum network. By deploying and using these contracts, users can enjoy the benefits of a decentralized financial system that is transparent, secure, and accessible to all.

This smart contract program provides a powerful tool for managing assets securely and programmatically on the Ethereum blockchain.

---

## 📜 License

This project is licensed under a **Custom NonCommercial Attribution License**.

- ✅ Free to use, modify, and share for **non-commercial** and **educational** purposes
- ❌ **Commercial use, resale, or monetization** is strictly prohibited without prior written consent
- 📛 Attribution required: Developed by Mohammad Nasser Haji Hashemabad (https://mohammadnasser.com)

📬 For commercial licensing or inquiries: [info@mohammadnasser.com](mailto:info@mohammadnasser.com)
