// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/SVG.sol";

contract CounterTest is Test {
    string [3][25] colorSchemes = [
                                  ["0.52, 0.47, 0.47, 1.0", "0.37, 0.21, 0.21, 1.0", "1.0, 0.07, 0.09, 1.0"],
                                  ["0.12, 0.17, 0.17, 1.0", "0.21, 0.21, 0.37, 1.0", "0.3, 0.37, 1.0, 1.0"],
                                  ["0.69, 0.6, 0.6, 1.0", "0.42, 0.49, 0.49, 1.0", "0.22, 0.97, 0.27, 1.0"],
                                  ["0.37, 0.21, 0.21, 1.0", "0.49, 0.49, 0.49, 1.0", "0.98, 0.94, 0.07, 1.0"],
                                  ["0.15, 0.13, 0.01, 1.0", "0.37, 0.41, 0.73, 1.0", "0.98, 0.08, 0.81, 1.0"],
                                   ["0.30, 0.27, 0.25, 1.0", "0.28, 0.25, 0.23, 1.0", "0.95, 0.20, 0.25, 1.0"],
    ["0.22, 0.20, 0.18, 1.0", "0.20, 0.18, 0.17, 1.0", "0.25, 0.90, 0.35, 1.0"],
    ["0.28, 0.27, 0.26, 1.0", "0.25, 0.23, 0.22, 1.0", "0.10, 0.50, 0.95, 1.0"],
    ["0.27, 0.25, 0.24, 1.0", "0.25, 0.23, 0.21, 1.0", "0.95, 0.60, 0.10, 1.0"],
    ["0.25, 0.23, 0.21, 1.0", "0.22, 0.21, 0.20, 1.0", "0.15, 0.95, 0.60, 1.0"],
    ["0.28, 0.27, 0.26, 1.0", "0.26, 0.24, 0.23, 1.0", "0.85, 0.10, 0.60, 1.0"],
    ["0.29, 0.28, 0.26, 1.0", "0.27, 0.26, 0.25, 1.0", "0.45, 0.15, 0.95, 1.0"],
    ["0.27, 0.26, 0.25, 1.0", "0.24, 0.23, 0.22, 1.0", "0.10, 0.70, 0.25, 1.0"],
    ["0.30, 0.28, 0.27, 1.0", "0.28, 0.27, 0.25, 1.0", "0.55, 0.30, 0.95, 1.0"],
    ["0.27, 0.26, 0.25, 1.0", "0.26, 0.25, 0.23, 1.0", "0.05, 0.80, 0.70, 1.0"],
    ["0.30, 0.28, 0.27, 1.0", "0.27, 0.26, 0.25, 1.0", "0.95, 0.45, 0.30, 1.0"],
    ["0.28, 0.27, 0.25, 1.0", "0.26, 0.24, 0.23, 1.0", "0.70, 0.10, 0.85, 1.0"],
    ["0.29, 0.28, 0.26, 1.0", "0.27, 0.26, 0.24, 1.0", "0.35, 0.95, 0.20, 1.0"],
    ["0.27, 0.25, 0.24, 1.0", "0.25, 0.24, 0.23, 1.0", "0.20, 0.60, 0.90, 1.0"],
    ["0.28, 0.27, 0.26, 1.0", "0.27, 0.26, 0.25, 1.0", "0.95, 0.85, 0.15, 1.0"],
    ["0.29, 0.28, 0.27, 1.0", "0.28, 0.27, 0.26, 1.0", "0.10, 0.30, 0.95, 1.0"],
    ["0.28, 0.27, 0.26, 1.0", "0.26, 0.24, 0.23, 1.0", "0.80, 0.15, 0.75, 1.0"],
    ["0.27, 0.25, 0.24, 1.0", "0.25, 0.23, 0.22, 1.0", "0.65, 0.95, 0.10, 1.0"],
    ["0.30, 0.29, 0.27, 1.0", "0.28, 0.26, 0.25, 1.0", "0.40, 0.25, 0.90, 1.0"],
    ["0.29, 0.27, 0.26, 1.0", "0.27, 0.26, 0.24, 1.0", "0.15, 0.75, 0.55, 1.0"]

                                  ];

    function setUp() public {
    }

    function testIncrement() public {
        console.log(SVG.generateSVG(61, colorSchemes[2]));
    }

    function testSetNumber(uint256 x) public {
    }
}
