// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Kalkulator {
    uint256 public angka = 10;

    function tambah(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    function kali(uint256 a, uint256 b) public pure returns (uint256) {
        return a * b;
    }

    function baca() public view returns (uint256) {
        return angka;
    }

    function simpan(uint256 baru) public { angka = baru; }
}
