// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {OptIn} from "../src/OptIn.sol";

contract OptInTest is Test {
    OptIn public optIn;

    function setUp() public {
        optIn = new OptIn();
    }
}
