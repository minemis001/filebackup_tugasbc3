// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract KotakDonasi {
    uint256 public jumlahSetoran;

    event Donasi(address indexed dari, uint256 weiDikirim);

    receive() external payable {
        jumlahSetoran += 1;
        emit Donasi(msg.sender, msg.value);
    }

    function setor() external payable {
        require(msg.value > 0, "Harus kirim ETH");
        jumlahSetoran += 1;
        emit Donasi(msg.sender, msg.value);
    }

    function saldo() external view returns (uint256) {
        return address(this).balance;
    }
}
