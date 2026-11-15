// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Pesan {
    string public tersimpan = "Awal";

    function setPesan(string calldata baru) external {
        tersimpan = baru;
    }

    function ulang(string memory masukan) public pure returns (string memory) {
        return string.concat(masukan, masukan);
    }
}
