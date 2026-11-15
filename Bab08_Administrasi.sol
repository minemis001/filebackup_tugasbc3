// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Administrasi {
    address public owner;
    uint256 public batas = 100;

    constructor() { owner = msg.sender; }

    modifier hanyaOwner() {
        require(msg.sender == owner, "Bukan owner");
        _;
    }

    function ubahBatas(uint256 baru) external hanyaOwner {
        require(baru > 0, "Harus positif");
        batas = baru;
    }

    function gantiOwner(address baru) external hanyaOwner {
        require(baru != address(0), "Alamat nol ditolak");
        owner = baru;
    }
}
