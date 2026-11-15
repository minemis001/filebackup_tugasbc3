// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Penilaian {
    uint256 public nilai;

    function atur(uint256 baru) public {
        require(baru >= 1, "Nilai minimal 1");
        require(baru <= 100, "Nilai maksimal 100");
        nilai = baru;
    }

    function status() public view returns (string memory) {
        if (nilai >= 70) { return "Lulus"; }
        else { return "Remedial"; }
    }
}
