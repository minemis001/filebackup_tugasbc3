// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract DaftarNilai {
    uint256[] public daftar;

    function tambah(uint256 x) public { daftar.push(x); }

    function total() public view returns (uint256 hasil) {
        for (uint256 i = 0; i < daftar.length; i++) {
            hasil += daftar[i];
        }
    }

    function jumlah() public view returns (uint256) {
        return daftar.length;
    }

    function rataRata() public view returns (uint256) {
        require(daftar.length > 0, "Array kosong");
        return total() / daftar.length;
    }
}
