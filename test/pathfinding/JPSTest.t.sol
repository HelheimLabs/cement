// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "forge-std/Test.sol";
import {PQ, PriorityQueue} from "../../contracts/utils/PQ.sol";
import {Coordinate as Coord} from "../../contracts/utils/Coordinate.sol";
import {JPS} from "../../contracts/pathfinding/JPS.sol";

contract JPSTest is Test {
    using PQ for PriorityQueue;

    uint8[][] map;
    uint256[][] field;

    function setUp() public {
        uint8[][] memory input = new uint8[][](5);
        input[0] = new uint8[](5);
        input[1] = new uint8[](5);
        input[2] = new uint8[](5);
        input[2][0] = 1;
        input[2][1] = 1;
        input[2][2] = 1;
        input[2][3] = 1;
        input[3] = new uint8[](5);
        input[4] = new uint8[](5);
        map = input;
        field = JPS.generateField(map);
    }

    function test_FieldIsGood() public {
        uint8[][] memory input = new uint8[][](3);
        input[0] = new uint8[](3);
        input[1] = new uint8[](3);
        input[1][1] = 1;
        input[2] = new uint8[](3);
        printInput(input);
        field = JPS.generateField(input);
        // check boundary
        assertTrue(field[0][3] == 1024);
        assertTrue(field[4][3] == 1024);
        assertTrue(field[3][0] == 1024);
        assertTrue(field[3][4] == 1024);
        // check the leftmost and lowest coordinate
        assertFalse(field[1][1] == 1024);
        // check the central obstacle
        assertTrue(field[2][2] == 1024);
    }

    function test_FindPath() public {
        uint8[][] memory input = new uint8[][](5);
        input[0] = new uint8[](5);
        input[1] = new uint8[](5);
        input[2] = new uint8[](5);
        input[2][0] = 1;
        input[2][1] = 1;
        input[2][2] = 1;
        input[2][3] = 1;
        input[3] = new uint8[](5);
        input[4] = new uint8[](5);
        uint256[] memory path = JPS.findPath(input, 0, 0, 4, 0);
        for (uint256 i; i < path.length; ++i) {
            (uint256 x, uint256 y) = Coord.decompose(path[i]);
            console.log("(%d,%d)", x, y);
        }
    }

    function printInput(uint8[][] memory _input) private view {
        for (uint256 i; i < 3; ++i) {
            console.log(" %d  %d  %d ", _input[0][2 - i], _input[1][2 - i], _input[2][2 - i]);
        }
    }
}
