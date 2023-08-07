// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import "forge-std/Test.sol";
import {PQ, PriorityQueue} from "../../contracts/utils/PQ.sol";

contract JPSTest is Test {
    using PQ for PriorityQueue;

    function setUp() public {
    }

    function test_PQ() public {
        PriorityQueue memory pq = PQ.New(5);
        pq.AddTask(1, 1);
        pq.AddTask(2, 2);
        pq.AddTask(3, 30);
        pq.AddTask(4, 4);
        pq.AddTask(5, 5);
        for (uint256 i; i < 5; ++i) {
            console.log("Pop task, data %d", pq.PopTask());
        }
    }
}
