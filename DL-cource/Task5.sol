// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

struct Point {
    uint256 x;
    uint256 y;
}

contract UintStorage {
    uint256 private one;
    mapping(uint256 => Point) private pointMap;

    constructor() {
        one = 1;
        pointMap[12] = Point(12, 12);
    }

    function setNewValues(uint256 first, Point calldata point) external virtual {}

    function getStorageValuesSum() external view returns (uint256) {
        return one + pointMap[12].x + pointMap[12].y;
    }

    function getMapValue(uint256 key) external view returns (Point memory) {
        return pointMap[key];
    }
}

contract StrangeCalculator is UintStorage {
    function setNewValues(uint256 first, Point calldata point) external override {
        uint256 key = 12;

        assembly {
            sstore(0x0, first) // changes the "one" 

            mstore(0x0, key) // stores the key in memorys
            mstore(0x20, 1) // ensures that memory position 0x20 is aligned to a 32-byte boundary by setting its value to 1
            let slot := keccak256(0x0, 0x40) // gets Point's slot

            sstore(slot, calldataload(0x24)) // stores the "x" value 
            sstore(add(slot, 1), calldataload(0x44)) // stores the "y" value in the next storage slot 
        }
    }
}


contract Tester {
function set(StrangeCalculator strangeCalculator_) external {
        strangeCalculator_.setNewValues(734673, Point(3525, 245425));
    }
}
