// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract ProfilMahasiswa {
    struct Profil { string nama; uint256 nim; bool aktif; uint256 nilai; }

    Profil[] public semua;

    function tambah(string calldata nama, uint256 nim, uint256 nilai) external {
        semua.push(Profil(nama, nim, true, nilai));
    }

    function jumlah() external view returns (uint256) {
        return semua.length;
    }
}
