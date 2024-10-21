# Metacrafters Eth+Avax Course: Module 3 Project 

This repository contains the Solidity code for `Cust_ERC20`, a custom ERC-20 token contract built on the Ethereum blockchain. The contract is implemented using the OpenZeppelin library, which provides reusable and secure implementations of standard Ethereum smart contract functionalities. The `Cust_ERC20` contract allows minting, burning, and transferring tokens with additional custom logic.

## What is ERC-20?

ERC-20 is a widely used standard for fungible tokens on the Ethereum blockchain. It defines a common interface for tokens, making them interoperable with wallets, exchanges, and decentralized applications (dApps). Some of the key functions defined in the ERC-20 standard include:

- **`totalSupply()`**: Returns the total number of tokens in existence.
- **`balanceOf(address account)`**: Returns the balance of a specific account.
- **`transfer(address to, uint256 amount)`**: Transfers a specified amount of tokens to a given address.
- **`approve(address spender, uint256 amount)`**: Approves another address to spend a specified amount of tokens on behalf of the caller.
- **`transferFrom(address from, address to, uint256 amount)`**: Transfers tokens from one address to another using an allowance.
- **`allowance(address owner, address spender)`**: Returns the remaining number of tokens that `spender` is allowed to spend on behalf of `owner`.

## OpenZeppelin

[OpenZeppelin](https://openzeppelin.com/) is a popular library that provides secure and community-reviewed implementations of smart contracts, including the ERC-20 token standard. By using OpenZeppelin, developers can avoid reinventing the wheel and focus on their specific use cases, leveraging tested and battle-hardened code. OpenZeppelin’s contracts follow best practices and include optimizations for gas efficiency and security.

## Cust_ERC20 Contract Explanation

The `Cust_ERC20` contract extends the standard `ERC20` implementation provided by OpenZeppelin, adding custom functions for minting, burning, and transferring tokens. Here’s a detailed breakdown of the contract:

### Constructor

```solidity
constructor(string memory name, string memory symbol) ERC20(name, symbol) {}
```

The constructor initializes the ERC-20 token with a `name` and `symbol` that represent the token’s identity. It leverages OpenZeppelin's `ERC20` constructor to set up the token’s properties.

### Functions

#### `mint(uint256 amount)`

```solidity
function mint(uint256 amount) public {
    _mint(msg.sender, amount);
}
```

- **Description**: Mints a specified `amount` of tokens and assigns them to the caller's address.
- **Use Case**: This function can be used to create new tokens, increasing the total supply.
- **Access**: Currently, anyone can call this function to mint new tokens, so be cautious of its usage in production environments.

#### `burn(uint256 amount)`

```solidity
function burn(uint256 amount) public {
    _burn(msg.sender, amount);
}
```

- **Description**: Burns a specified `amount` of tokens from the caller’s balance, reducing the total supply.
- **Use Case**: Allows users to permanently destroy tokens, which can be useful in deflationary token models or to reduce the token supply.
- **Access**: The caller must have at least the specified amount of tokens to burn.

#### `customTransfer(address to, uint256 amount)`

```solidity
function customTransfer(address to, uint256 amount) public returns (bool) {
    require(to != address(0), "Transfer to the zero address is not allowed");
    require(balanceOf(msg.sender) >= amount, "Insufficient balance");

    _transfer(msg.sender, to, amount);
    return true;
}
```

- **Description**: A custom function to transfer tokens from the caller’s address to another address.
- **Use Case**: This function adds an additional check to ensure that the transfer is not being made to the zero address, enhancing the security of token transfers.
- **Access**: The caller must have enough balance to transfer the specified `amount`.

## How to Use

1. **Compile the Contract**: Use a Solidity compiler like Remix, Hardhat, or Truffle to compile the contract.
2. **Deploy the Contract**: Deploy the contract to your desired Ethereum network by providing a `name` and `symbol` for your token.
3. **Mint Tokens**: Call the `mint` function to create new tokens and allocate them to your address.
4. **Burn Tokens**: Use the `burn` function to reduce your token balance and decrease the total supply.
5. **Transfer Tokens**: Use `customTransfer` to securely transfer tokens to another address.

## Prerequisites

- [Node.js](https://nodejs.org/) and npm installed.
- A development environment like [Hardhat](https://hardhat.org/) or [Remix](https://remix.ethereum.org/).
- Basic knowledge of Solidity and smart contract deployment.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more information.
