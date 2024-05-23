markdown
Копировать код
# Raffle Smart Contract Project

This project implements a decentralized raffle system using smart contracts. The main contract, `Raffle.sol`, allows users to enter a raffle by sending a specified amount of Ether. A winner is selected at random using Chainlink VRF (Verifiable Random Function).

## Table of Contents

- [Project Overview](#project-overview)
- [Smart Contracts](#smart-contracts)
- [Setup](#setup)
- [Testing](#testing)
- [Deployment](#deployment)
- [Usage](#usage)
- [License](#license)

## Project Overview

The Raffle smart contract allows participants to enter a raffle by paying an entrance fee. After a predefined interval, a winner is selected randomly, and the prize pool is transferred to the winner. The randomness is ensured using Chainlink VRF.

## Smart Contracts

### Raffle.sol

The main contract that handles the raffle logic. Key functions include:
- `enterRaffle()`: Allows a user to enter the raffle.
- `performUpkeep()`: Checks if the raffle can be drawn and triggers the randomness request.
- `fulfillRandomWords()`: Called by Chainlink VRF to provide a random number and select the winner.

### HelperConfig.s.sol

A helper contract for configuration settings, such as entrance fee, interval, and Chainlink VRF parameters.

### DeployRaffle.s.sol

A deployment script to deploy the `Raffle.sol` contract.

## Setup

### 1. Clone the Repository:
```bash
git clone https://github.com/yourusername/raffle-smart-contract.git
cd raffle-smart-contract
```
### 2. Install Dependencies:
Make sure you have Foundry installed. Then, install the project dependencies:
```bash
forge install
```
### 3. Environment Variables:
Create a `.env` file to store your environment variables. You will need the following variables:
```plaintext
ALCHEMY_API_KEY=<your-alchemy-api-key>
PRIVATE_KEY=<your-private-key>
```

## Testing
To run the tests, use the following command:

```bash
forge test
```
The tests cover various scenarios, including entering the raffle, checking upkeep conditions, performing upkeep, and fulfilling random words. Ensure you have a local Ethereum node running (such as Anvil) or connect to a testnet.

## Deployment
To deploy the smart contract to a network, use the deployment script:

```bash
forge script script/DeployRaffle.s.sol --rpc-url <network-rpc-url> --broadcast --verify --etherscan-api-key <your-etherscan-api-key>
```
Replace <network-rpc-url> with the RPC URL of the network you are deploying to and <your-etherscan-api-key> with your Etherscan API key for verification.

## Usage
### 1. Enter the Raffle:
Call the `enterRaffle` function with the required entrance fee to participate.
### 2. Check Upkeep:
The Chainlink Keeper nodes will call `checkUpkeep` to see if the raffle can be drawn.
### 3. Perform Upkeep:
Once `checkUpkeep` returns true, `performUpkeep` is called to request a random number from Chainlink VRF.
### 4. Fulfill Random Words:
Chainlink VRF will call `fulfillRandomWords` to provide a random number and determine the winner.

## License
This project is licensed under the MIT License.