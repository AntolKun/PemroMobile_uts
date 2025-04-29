import 'package:flutter/material.dart';

class NilaiMahasiswaScreen extends StatefulWidget {
  final String username;

  const NilaiMahasiswaScreen({required this.username});

  @override
  _NilaiMahasiswaScreenState createState() => _NilaiMahasiswaScreenState();
}

class _NilaiMahasiswaScreenState extends State<NilaiMahasiswaScreen> {
  final _tugasController = TextEditingController();
  final _utsController = TextEditingController();
  final _uasController = TextEditingController();

  double? _nilaiAkhir;
  String? _grade;

  void _hitungNilai() {
    final tugas = double.tryParse(_tugasController.text) ?? 0;
    final uts = double.tryParse(_utsController.text) ?? 0;
    final uas = double.tryParse(_uasController.text) ?? 0;

    final nilaiAkhir = (tugas + uts + uas) / 3;
    String grade;

    if (nilaiAkhir >= 80) {
      grade = 'A';
    } else if (nilaiAkhir >= 70) {
      grade = 'B';
    } else if (nilaiAkhir >= 60) {
      grade = 'C';
    } else if (nilaiAkhir >= 50) {
      grade = 'D';
    } else {
      grade = 'E';
    }

    setState(() {
      _nilaiAkhir = nilaiAkhir;
      _grade = grade;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nilai Mahasiswa')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang, ${widget.username}!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _tugasController,
              decoration: InputDecoration(
                labelText: 'Nilai Tugas',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            TextField(
              controller: _utsController,
              decoration: InputDecoration(
                labelText: 'Nilai UTS',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            TextField(
              controller: _uasController,
              decoration: InputDecoration(
                labelText: 'Nilai UAS',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _hitungNilai, child: Text('Hitung')),
            SizedBox(height: 20),
            if (_nilaiAkhir != null && _grade != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nilai Tugas: ${_tugasController.text}'),
                  Text('Nilai UTS: ${_utsController.text}'),
                  Text('Nilai UAS: ${_uasController.text}'),
                  Text('Nilai Akhir: ${_nilaiAkhir!.toStringAsFixed(2)}'),
                  Text('Grade: $_grade'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
