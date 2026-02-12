<?php
$koneksi = new mysqli("localhost", "root", "", "db_rs_tes");
$query = mysqli_query($koneksi, "SELECT * FROM pasien");
$data = mysqli_fetch_all($query, MYSQLI_ASSOC);
echo json_encode($data);
?>