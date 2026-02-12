import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/Pasien.dart';

class PasienService {
  static Future<List<Pasien>> getPasien() async {
    final response = await http.get(
      Uri.parse("http://192.168.4.29/api_tes/read.php"),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Pasien.fromJson(e)).toList();
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  static Future<Pasien> tambahPasien(Pasien pasien) async {
    final response = await http.post(
      Uri.parse("http://192.168.4.29/api_tes/create.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(pasien.toJson()),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['success']) {
        return Pasien.fromJson(json['data']);
      } else {
        throw Exception(json['message']);
      }
    } else {
      throw Exception("Gagal terhubung ke server");
    }
  }

  static Future<bool> deletePasien(int id) async {
    final response = await http.get(
      Uri.parse("http://192.168.4.29/api_tes/delete.php?id=$id"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        return true;
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception("Gagal terhubung ke server");
    }
  }

  // static Future<Pasien> updatePasien(Pasien pasien) async {
  //   final response = await http.post(
  //     Uri.parse("http://192.168.4.29/api_tes/update.php"),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode(pasien.toJson()),
  //   );

  //   if (response.statusCode == 200) {
  //     final json = jsonDecode(response.body);

  //     if (json['success']) {
  //       return Pasien.fromJson(json['data']);
  //     } else {
  //       throw Exception(json['message']);
  //     }
  //   } else {
  //     throw Exception("Gagal terhubung ke server");
  //   }
  // }

  static Future<Pasien> updatePasien(Pasien pasien) async {
    final response = await http.put(
      Uri.parse("http://192.168.4.29/api_tes/update.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(pasien.toJson()),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['success']) {
        return Pasien.fromJson(json['data']);
      } else {
        throw Exception(json['message']);
      }
    } else {
      throw Exception("Gagal terhubung ke server");
    }
  }
}
