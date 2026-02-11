import 'package:flutter/material.dart';
import 'package:pelatihan_flutter_2/Service/PasienService.dart';
import 'package:pelatihan_flutter_2/SetelahLogin.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'Model/Pasien.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ListPage());
  }
}

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Pasien"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: PasienService.getPasien(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (asyncSnapshot.hasError) {
            return Center(child: Text("Error: ${asyncSnapshot.error}"));
          }

          final pasienList = asyncSnapshot.data!;

          if (pasienList.isEmpty) {
            return const Center(child: Text("Data kosong"));
          }

          return ListView.builder(
            itemCount: pasienList.length,
            itemBuilder: (context, index) => ListTile(
              title: Text("${pasienList[index].nama}"),
              subtitle: Text("Poli: ${pasienList[index].poli}"),
              trailing: Text(
                "Waktu Berobat: ${pasienList[index].tanggalDaftar}",
              ),
            ),
          );
        },
      ),
      floatingActionButton: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
        child: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistrationPage()),
            );
          },
          icon: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController namaPasienController = TextEditingController();
  List<DateTime?> _selectedDates = [];
  String? selectedPoli;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pendaftaran Pasien"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: namaPasienController,
            decoration: InputDecoration(
              label: Text("Nama Pasien"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          SizedBox(height: 10),
          DropdownSearch<String>(
            onChanged: (value) => selectedPoli = value,
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                hintText: 'Pilih Poli',
                border: OutlineInputBorder(),
              ),
            ),
            items: (f, cs) => ['Umum', 'Anak', 'Jantung'],
            popupProps: PopupProps.menu(fit: FlexFit.loose),
          ),
          SizedBox(height: 10),
          OutlinedButton(
            onPressed: () async {
              var results = await showCalendarDatePicker2Dialog(
                context: context,
                config: CalendarDatePicker2WithActionButtonsConfig(),
                dialogSize: const Size(325, 400),
                value: _selectedDates,
                borderRadius: BorderRadius.circular(15),
              );

              if (results != null) {
                setState(() {
                  _selectedDates = results;
                });
              }
            },
            child: const Text("Pilih Tanggal"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              String tanggal = DateFormat(
                'yyyy-MM-dd',
              ).format(_selectedDates.first!);

              print(selectedPoli);
              print(tanggal);
              print(namaPasienController.text);

              Pasien pasien = Pasien(
                nama: namaPasienController.text,
                poli: selectedPoli,
                tanggalDaftar: tanggal,
              );

              await PasienService.tambahPasien(pasien);
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => ResultPage()),
              // );
            },
            child: Text("Kirim Data"),
          ),
        ],
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pasien"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            "Nama Pasien",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text("Poli Pasien", style: TextStyle(fontSize: 12)),
          Text("Tanggal Daftar", style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
