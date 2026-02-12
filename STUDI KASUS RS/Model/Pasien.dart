class Pasien {
  String? id;
  String? nama;
  String? poli;
  String? tanggalDaftar;

  Pasien({this.id, this.nama, this.poli, this.tanggalDaftar});

  Pasien.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    nama = json['nama'];
    poli = json['poli'];
    tanggalDaftar = json['tanggal_daftar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['poli'] = this.poli;
    data['tanggal_daftar'] = this.tanggalDaftar;
    return data;
  }
}
