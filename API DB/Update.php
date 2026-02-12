<?php
header("Content-Type: application/json");

// Pastikan method adalah PUT
if ($_SERVER['REQUEST_METHOD'] !== 'PUT') {
    http_response_code(405);
    echo json_encode([
        "success" => false,
        "message" => "Method tidak diizinkan. Gunakan PUT."
    ]);
    exit();
}

$koneksi = new mysqli("localhost", "root", "", "db_rs_tes");

if ($koneksi->connect_error) {
    http_response_code(500);
    echo json_encode([
        "success" => false,
        "message" => "Koneksi gagal"
    ]);
    exit();
}

// Ambil data dari body (PUT tidak punya $_POST)
$data = json_decode(file_get_contents("php://input"), true);

$id = $data['id'] ?? null;
$nama = $data['nama'] ?? null;
$poli = $data['poli'] ?? null;
$tanggal = $data['tanggal_daftar'] ?? null;

// Validasi data
if (!$id || !$nama || !$poli || !$tanggal) {
    http_response_code(400);
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

    // Ambil ulang data terbaru (pakai prepared biar aman)
    $stmt2 = $koneksi->prepare("SELECT * FROM pasien WHERE id=?");
    $stmt2->bind_param("i", $id);
    $stmt2->execute();
    $result = $stmt2->get_result();
    $updatedData = $result->fetch_assoc();

    echo json_encode([
        "success" => true,
        "data" => $updatedData
    ]);

    $stmt2->close();

} else {
    http_response_code(500);
    echo json_encode([
        "success" => false,
        "message" => "Gagal update data"
    ]);
}

$stmt->close();
$koneksi->close();
?>
