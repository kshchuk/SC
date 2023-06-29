// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

abstract contract AuthorizedValue {
    uint256 private value;

    address private messageOwner = 0x5A902DB2775515E98ff5127EFEa53D1CC9EE1912;

    function setValueRaw(
        uint256 value_,
        bytes32 messageHash,
        bytes32 r,
        bytes32 s,
        uint8 v
    ) public {
        address signer = ecrecover(messageHash, v, r, s);

        require(signer == messageOwner, "Invalid signature.");

        value = value_;
    }

    function setValue(uint256 value_, bytes memory signature) external virtual;

    function getValue() external view returns (uint256) {
        return value;
    }

    function getMessageOwner() external view returns (address) {
        return messageOwner;
    }
}

contract ValueSetter is AuthorizedValue {
    function setValue(uint256 value_, bytes memory signature) external override {
        bytes32 data = keccak256(abi.encode(value_, block.chainid, "ValueSetter"));
        bytes32 messageHash = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", data));

        (bytes32 r, bytes32 s, uint8 v) = splitSignature(signature);
        setValueRaw(value_, messageHash, r, s, v);
    }

    function splitSignature(bytes memory signature) 
            private pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(signature.length == 65, "Invalid signature length");

        assembly {
            // first 32 bytes - signature length
            r := mload(add(signature, 32))
            s := mload(add(signature, 64))
            // first byte of the next 32 bytes)
            v := byte(0, mload(add(signature, 96)))
        }
    }
}
