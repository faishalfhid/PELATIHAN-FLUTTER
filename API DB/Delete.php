<?php
header("Content-Type: application/json");

$koneksi = new mysqli("localhost", "root", "", "db_rs_tes");

if ($koneksi->connect_error) {
    echo json_encode([
        "status" => "error",
        "message" => "Koneksi gagal"
    ]);
    exit();
}

// Ambil id dari parameter URL (GET)
$id = $_GET['id'] ?? null;

if (!$id) {
    echo json_encode([
        "status" => "error",
        "message" => "ID tidak ditemukan"
    ]);
    exit();
}

// Gunakan prepared statement (lebih aman)
$stmt = $koneksi->prepare("DELETE FROM pasien WHERE id = ?");
$stmt->bind_param("i", $id);

if ($stmt->execute()) {
    echo json_encode([
        "success" => true,
        "message" => "Data berhasil dihapus"
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Gagal menghapus data"
    ]);
}

$stmt->close();
$koneksi->close();
?>
