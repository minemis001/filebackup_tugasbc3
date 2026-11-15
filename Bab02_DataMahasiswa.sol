// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract DataMahasiswa {
    uint256 public nilai = 80;
    bool public aktif = true;
    string public nama = "Ani";
    address public pengajar;
    bool public sudahLulus;

    constructor() { pengajar = msg.sender; }

    function ubahNilai(uint256 baru) public { nilai = baru; }

    function ubahNama(string calldata baru) public { nama = baru; }
}
