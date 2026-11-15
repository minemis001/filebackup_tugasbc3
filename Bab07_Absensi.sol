// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Absensi {
    mapping(address => bool) public hadir;
    mapping(address => uint256) public poin;

    function absen() external {
        require(!hadir[msg.sender], "Sudah absen");
        hadir[msg.sender] = true;
    }

    function cekSaya() external view returns (bool) {
        return hadir[msg.sender];
    }

    function tambahPoin() external {
        poin[msg.sender] += 1;
    }
}
