// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/SVG.sol";

contract CounterTest is Test {

    function setUp() public {
    }

    function testIncrement() public {
        console.log(SVG.generateSVG(61));
    }

    function testSetNumber(uint256 x) public {
    }
}
