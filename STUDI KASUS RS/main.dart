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

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<List<Pasien>> pasienList;
  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void refreshData() {
    pasienList = PasienService.getPasien();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Pasien"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                refreshData();
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: pasienList,
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
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      id: pasienList[index].id!,
                      namaPasien: pasienList[index].nama!,
                      poliPasien: pasienList[index].poli!,
                      tanggalDaftar: pasienList[index].tanggalDaftar!,
                    ),
                  ),
                );
                if (result == true) {
                  setState(() {
                    refreshData();
                  });
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
        child: IconButton(
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistrationPage()),
            );
            if (result == true) {
              setState(() {
                refreshData();
              });
            }
            // print(result);
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
                config: CalendarDatePicker2WithActionButtonsConfig(
                  firstDate: DateTime.now(),
                ),
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
                id: "0",
                nama: namaPasienController.text,
                poli: selectedPoli,
                tanggalDaftar: tanggal,
              );

              await PasienService.tambahPasien(pasien);

              Navigator.pop(context, true);
            },
            child: Text("Kirim Data"),
          ),
        ],
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.id,
    required this.namaPasien,
    required this.poliPasien,
    required this.tanggalDaftar,
  });

  final String id;
  final String namaPasien;
  final String poliPasien;
  final String tanggalDaftar;

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
            namaPasien,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text("ID Pasien: $id", style: TextStyle(fontSize: 12)),
          Text(poliPasien, style: TextStyle(fontSize: 12)),
          Text(tanggalDaftar, style: TextStyle(fontSize: 12)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final bool? result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPage(
                    id: id,
                    namaPasien: namaPasien,
                    poliPasien: poliPasien,
                    tanggalDaftar: tanggalDaftar,
                  ),
                ),
              );
              if (result == true) {
                Navigator.pop(context, true);
              }
            },
            child: Text("Edit Data"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: () async {
              try {
                await PasienService.deletePasien(int.parse(id));

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Data berhasil dihapus")),
                );

                Navigator.pop(
                  context,
                  true,
                ); // kirim sinyal ke halaman sebelumnya
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            child: Text("Hapus Data"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class EditPage extends StatefulWidget {
  const EditPage({
    super.key,
    required this.id,
    required this.namaPasien,
    required this.poliPasien,
    required this.tanggalDaftar,
  });

  final String id;
  final String namaPasien;
  final String poliPasien;
  final String tanggalDaftar;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController namaController;
  late String selectedPoli;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.namaPasien);
    selectedPoli = widget.poliPasien;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Data Pasien"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: "Nama Pasien",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: selectedPoli,
              items: ['Umum', 'Anak', 'Jantung']
                  .map(
                    (poli) => DropdownMenuItem(value: poli, child: Text(poli)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedPoli = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: "Pilih Poli",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Pasien pasien = Pasien(
                  id: "${widget.id}",
                  nama: namaController.text,
                  poli: selectedPoli,
                  tanggalDaftar: widget.tanggalDaftar,
                );

                await PasienService.updatePasien(pasien);

                Navigator.pop(context, true); // kirim sinyal refresh
              },
              child: const Text("Update Data"),
            ),
          ],
        ),
      ),
    );
  }
}
