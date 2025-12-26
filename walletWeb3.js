if (typeof window.ethereum !== 'undefined') {
    const web3 = new Web3(window.ethereum);
    let userAddress;

    async function connectWallet() {
        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
        userAddress = accounts[0];
        console.log('Connected wallet address:', userAddress);
    }

    async function getBalance(address) {
        const tokenAddress = '0xYourTokenAddress'; // آدرس قرارداد توکن
        const abi = [
            {
                "constant": true,
                "inputs": [{"name": "_owner", "type": "address"}],
                "name": "balanceOf",
                "outputs": [{"name": "balance", "type": "uint256"}],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
            }
        ];
        const contract = new web3.eth.Contract(abi, tokenAddress);
        const balance = await contract.methods.balanceOf(address).call();
        return web3.utils.fromWei(balance);
    }

    async function sendTokens(to, amount) {
        const tokenAddress = '0xYourTokenAddress'; // آدرس قرارداد توکن
        const abi = [
            {
                "constant": false,
                "inputs": [{"name": "to", "type": "address"}, {"name": "amount", "type": "uint256"}],
                "name": "transfer",
                "outputs": [{"name": "", "type": "bool"}],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
            }
        ];
        const contract = new web3.eth.Contract(abi, tokenAddress);

        await contract.methods.transfer(to, web3.utils.toWei(amount, 'ether')).send({ from: userAddress });
    }

    connectWallet();
} else {
    alert('Please install MetaMask!');
}
