<?php
$koneksi = new mysqli("localhost", "root", "", "db_rs_tes");

// Cek koneksi
if ($koneksi->connect_error) {
    die(json_encode([
        "success" => false,
        "message" => "Koneksi gagal"
    ]));
}

// Ambil data dari body JSON
$data = json_decode(file_get_contents("php://input"), true);

$nama = $data['nama'];
$poli = $data['poli'];
$tanggal_daftar = $data['tanggal_daftar'];

// Gunakan prepared statement (lebih aman)
$stmt = $koneksi->prepare("INSERT INTO pasien (nama, poli, tanggal_daftar) VALUES (?, ?, ?)");
$stmt->bind_param("sss", $nama, $poli, $tanggal_daftar);

if ($stmt->execute()) {

    // Ambil ID terakhir
    $last_id = $koneksi->insert_id;

    echo json_encode([
        "success" => true,
        "message" => "Data berhasil ditambahkan",
        "data" => [
            "id" => $last_id,
            "nama" => $nama,
            "poli" => $poli,
            "tanggal_daftar" => $tanggal_daftar
        ]
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Gagal menambahkan data"
    ]);
}

$stmt->close();
$koneksi->close();
?>
