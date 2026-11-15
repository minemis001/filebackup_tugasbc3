// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract CatatanNilai {
    uint256 public nilai;

    event NilaiDiubah(address indexed pengubah, uint256 baru);
    event NilaiDihapus(address indexed pengubah);

    function ubah(uint256 baru) external {
        nilai = baru;
        emit NilaiDiubah(msg.sender, baru);
    }

    function hapus() external {
        nilai = 0;
        emit NilaiDihapus(msg.sender);
    }
}
