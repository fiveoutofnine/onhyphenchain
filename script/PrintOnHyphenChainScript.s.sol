// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {OnHyphenChain} from "../src/OnHyphenChain.sol";

/// @notice A script to print the token URI returned by `OnHyphenChain` for
/// testing purposes.
contract PrintOnHyphenChainScript is Script {
    /// @notice The instance of `OnHyphenChain` that will be deployed after
    /// the script runs.
    OnHyphenChain internal onHyphenChain;

    /// @notice Deploys an instance of `onHyphenChain` then mints tokens #1,
    /// ..., and #9999.
    function setUp() public {
        onHyphenChain = new OnHyphenChain();
        for (uint256 i; i < 10000; ) {
            onHyphenChain.mint();
            unchecked {
                ++i;
            }
        }
    }

    /// @notice Prints the token URI for tokens #1, #20, #490, #2000, and #4545.
    function run() public view {
        console.log(onHyphenChain.tokenURI(1));
        console.log(onHyphenChain.tokenURI(20));
        console.log(onHyphenChain.tokenURI(490));
        console.log(onHyphenChain.tokenURI(2000));
        console.log(onHyphenChain.tokenURI(4545));
    }
}
