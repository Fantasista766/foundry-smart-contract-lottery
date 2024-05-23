// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {Raffle} from "../src/Raffle.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {SubscriptionCreator, SubscriptionFunder, ConsumerAdder} from "./Interactions.s.sol";

contract DeployRaffle is Script {
    function run() external returns (Raffle, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();
        (
            uint256 entranceFee,
            uint256 interval,
            address vrfCoordinator,
            bytes32 gasLane,
            uint64 subscriptionID,
            uint32 callbackGasLimit,
            address link,
            uint256 deployerKey
        ) = helperConfig.activeNetworkConfig();

        if (subscriptionID == 0) {
            SubscriptionCreator subscriptionCreator = new SubscriptionCreator();
            subscriptionID = subscriptionCreator.createSubscription(
                vrfCoordinator,
                deployerKey
            );

            SubscriptionFunder subsctionFunder = new SubscriptionFunder();
            subsctionFunder.fundSubscription(
                vrfCoordinator,
                subscriptionID,
                link,
                deployerKey
            );
        }

        vm.startBroadcast();
        Raffle raffle = new Raffle(
            entranceFee,
            interval,
            vrfCoordinator,
            gasLane,
            subscriptionID,
            callbackGasLimit
        );
        vm.stopBroadcast();

        ConsumerAdder consumerAdder = new ConsumerAdder();
        consumerAdder.addConsumer(
            address(raffle),
            vrfCoordinator,
            subscriptionID,
            deployerKey
        );
        return (raffle, helperConfig);
    }
}
