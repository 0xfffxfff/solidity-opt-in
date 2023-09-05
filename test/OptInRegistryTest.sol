// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {OptInRegistry} from "../src/OptInRegistry.sol";

contract OptInRegistryTest is Test {
    OptInRegistry public optIn;

    function setUp() public {
        optIn = new OptInRegistry(address(0), "default");
    }
}
