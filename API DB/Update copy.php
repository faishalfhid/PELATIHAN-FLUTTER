<?php
header("Content-Type: application/json");

$koneksi = new mysqli("localhost", "root", "", "db_rs_tes");

if ($koneksi->connect_error) {
    echo json_encode([
        "success" => false,
        "message" => "Koneksi gagal"
    ]);
    exit();
}

// Ambil data JSON dari body
$data = json_decode(file_get_contents("php://input"), true);

$id = $data['id'] ?? null;
$nama = $data['nama'] ?? null;
$poli = $data['poli'] ?? null;
$tanggal = $data['tanggal_daftar'] ?? null;

if (!$id || !$nama || !$poli || !$tanggal) {
    echo json_encode([
        "success" => false,
        "message" => "Data tidak lengkap"
    ]);
    exit();
}

// Update data
$stmt = $koneksi->prepare("UPDATE pasien SET nama=?, poli=?, tanggal_daftar=? WHERE id=?");
$stmt->bind_param("sssi", $nama, $poli, $tanggal, $id);

if ($stmt->execute()) {

    // Ambil ulang data terbaru
    $result = $koneksi->query("SELECT * FROM pasien WHERE id = $id");
    $updatedData = $result->fetch_assoc();

    echo json_encode([
        "success" => true,
        "data" => $updatedData
    ]);

} else {
    echo json_encode([
        "success" => false,
        "message" => "Gagal update data"
    ]);
}

$stmt->close();
$koneksi->close();
?>
