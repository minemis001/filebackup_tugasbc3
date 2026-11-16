// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Arisan Digital: iuran bergilir. Tiap ronde semua anggota membayar iuran,
// lalu seluruh uang terkumpul otomatis dikirim ke penerima ronde itu.
// Urutan penerima = urutan pendaftaran (tanpa acak, jadi adil dan bisa diperiksa).
contract ArisanDigital {
    address public admin;
    uint256 public iuran;       // dalam wei
    uint256 public maksAnggota;
    uint256 public ronde;       // ronde berjalan, mulai dari 0
    bool public dimulai;
    bool public selesai;

    address[] public anggota;
    mapping(address => bool) public terdaftar;
    // ronde => alamat => sudah bayar
    mapping(uint256 => mapping(address => bool)) public sudahBayar;
    uint256 public jumlahBayarRonde;

    event Daftar(address indexed anggota, uint256 nomorUrut);
    event ArisanDimulai(uint256 jumlahAnggota, uint256 iuran);
    event Bayar(uint256 indexed ronde, address indexed anggota);
    event Pemenang(uint256 indexed ronde, address indexed penerima, uint256 jumlah);
    event ArisanSelesai();

    modifier hanyaAdmin() {
        require(msg.sender == admin, "Bukan admin");
        _;
    }

    modifier hanyaAnggota() {
        require(terdaftar[msg.sender], "Bukan anggota");
        _;
    }

    // _iuranEth dalam satuan ether, mis. 1 berarti 1 ether per anggota per ronde
    constructor(uint256 _iuranEth, uint256 _maksAnggota) {
        require(_iuranEth > 0, "Iuran harus lebih dari 0");
        require(_maksAnggota >= 2, "Minimal 2 anggota");
        admin = msg.sender;
        iuran = _iuranEth * 1 ether;
        maksAnggota = _maksAnggota;
    }

    function daftar() public {
        require(!dimulai, "Arisan sudah dimulai");
        require(!terdaftar[msg.sender], "Sudah terdaftar");
        require(anggota.length < maksAnggota, "Anggota penuh");
        terdaftar[msg.sender] = true;
        anggota.push(msg.sender);
        emit Daftar(msg.sender, anggota.length);
    }

    function mulai() public hanyaAdmin {
        require(!dimulai, "Arisan sudah dimulai");
        require(anggota.length == maksAnggota, "Anggota belum lengkap");
        dimulai = true;
        emit ArisanDimulai(anggota.length, iuran);
    }

    function bayar() public payable hanyaAnggota {
        require(dimulai, "Arisan belum dimulai");
        require(!selesai, "Arisan selesai");
        require(msg.value == iuran, "Iuran harus pas");
        require(!sudahBayar[ronde][msg.sender], "Sudah bayar ronde ini");

        sudahBayar[ronde][msg.sender] = true;
        jumlahBayarRonde += 1;
        emit Bayar(ronde, msg.sender);

        if (jumlahBayarRonde == anggota.length) {
            _cairkan();
        }
    }

    // Dipanggil otomatis saat semua anggota sudah bayar.
    function _cairkan() private {
        address penerima = anggota[ronde];
        uint256 jumlah = iuran * anggota.length;
        uint256 rondeIni = ronde;

        // ubah state dulu, kirim uang terakhir
        jumlahBayarRonde = 0;
        ronde += 1;
        if (ronde == anggota.length) {
            selesai = true;
        }

        (bool ok, ) = payable(penerima).call{value: jumlah}("");
        require(ok, "Pengiriman gagal");
        emit Pemenang(rondeIni, penerima, jumlah);
        if (selesai) {
            emit ArisanSelesai();
        }
    }

    function jumlahAnggota() public view returns (uint256) {
        return anggota.length;
    }

    function saldoKontrak() public view returns (uint256) {
        return address(this).balance;
    }

    function penerimaRondeIni() public view returns (address) {
        require(dimulai, "Arisan belum dimulai");
        require(!selesai, "Arisan selesai");
        return anggota[ronde];
    }
}
