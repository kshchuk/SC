// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

library MyLib {
    function collideStorage(address, uint256 length) external {
        assembly {
            sstore(0x0, length) // store the array length
            let slot := keccak256(0x0, 0x20) // slot of the first element of the array
            
            for { let i := 0 } lt(i, length) { i := add(i, 1) } {
                sstore(add(slot, i), 1) // fills all elements of the array with "1"
            }
        }
    }
}