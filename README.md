This is a ToDo smart contract project made for a [Dapp](https://github.com/mabopoi/todo-dapp-frontend)

## Requirements

- NodeJS
- Ganache-cli
- Truffle

If you haven't installed ganache-cli or truffle globally, you can run:

    npm install -g ganache-cli truffle

## Installation

    git clone https://github.com/mabopoi/todo-dapp-contract
    npm install

## How to deploy the contract

First of all, ganache-cli must be running in order to have our test blockchain locally.
Once you do that, follow the next steps:

1.  Compiling the contracts

        truffle compile

2.  Migrating the contracts to the blockchain

        truffle migrate

### And you have deployed the contracts successfully!

## Running tests

    truffle test
