// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface IDataTypesPractice {
    function getInt256() external view returns (int256);

    function getUint256() external view returns (uint256);

    function getInt8() external view returns (int8);

    function getUint8() external view returns (uint8);

    function getBool() external view returns (bool);

    function getAddress() external view returns (address);

    function getBytes32() external view returns (bytes32);

    function getArrayUint5() external view returns (uint256[5] memory);

    function getArrayUint() external view returns (uint256[] memory);

    function getString() external view returns (string memory);

    function getBigUint() external pure returns (uint256);
}

contract MyContract is IDataTypesPractice {
    int256 i256 = -52535425;
    uint256 ui256 = 243323533;
    int8 i8 = -127;
    uint8 ui8 = 200;
    bool b = true;
    address ad = address(this);
    bytes32 b32 = 0x05416460deb76d57af601be17e777b93592d8d4d4a4096c57876a91c84f4a712;
    uint256[5] uintArray5 = [1, 2, 3, 4, 5];
    uint256[] uintArray;
    string str = "Hello World!";

    constructor() {
        uintArray = new uint256[](3);
    }

    function getInt256() external view override returns (int256) {
        return i256;
    }

    function getUint256() external view override returns (uint256) {
        return ui256;
    }

    function getInt8() external view override returns (int8) {
        return i8;
    }

    function getUint8() external view override returns (uint8) {
        return ui8;
    }

    function getBool() external view override returns (bool) {
        return b;
    }

    function getAddress() external view override returns (address) {
        return ad;
    }

    function getBytes32() external view override returns (bytes32) {
        return b32;
    }

    function getArrayUint5() external view override returns (uint256[5] memory) {
        return uintArray5;
    }

    function getArrayUint() external view override returns (uint256[] memory) {
        return uintArray;
    }

    function getString() external view override returns (string memory) {
        return str;
    }

    function getBigUint() external pure override returns (uint256) {
        uint256 v1 = 1;
        uint256 v2 = 2;
        
        return ~v2;
    }
}

