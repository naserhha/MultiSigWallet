from web3 import Web3

# اتصال به شبکه Rinkeby یا هر شبکه دیگری
w3 = Web3(Web3.HTTPProvider('https://rinkeby.infura.io/v3/YOUR_INFURA_PROJECT_ID'))

# آدرس قرارداد توکن
token_address = '0xYourTokenAddress'
abi = [
    {
        "constant": True,
        "inputs": [{"name": "_owner", "type": "address"}],
        "name": "balanceOf",
        "outputs": [{"name": "balance", "type": "uint256"}],
        "payable": False,
        "stateMutability": "view",
        "type": "function"
    }
]

# اتصال به قرارداد
contract = w3.eth.contract(address=token_address, abi=abi)

# تابع برای دریافت موجودی
def get_balance(address):
    return contract.functions.balanceOf(address).call()

# آدرس کیف پول
address = '0xYourWalletAddress'
balance = get_balance(address)
print(f'Balance: {balance / 10**18} Tokens')  # موجودی به واحد اصلی
