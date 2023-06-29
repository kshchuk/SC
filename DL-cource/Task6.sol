// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {MyLib} from  './MyLib.sol';

abstract contract ArrayStorage {
    uint256[] private array;

    function collide() external virtual;

    function getArray() external view returns (uint256[] memory) {
        return array;
    }
}

contract StorageCollider is ArrayStorage {
    using MyLib for *;
    uint256 arrayLength = 100;

    function collide() external override {
        address(this).collideStorage(arrayLength);
    }
}
