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

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _hitungNilai() {
    if (_tugasController.text.isEmpty ||
        _utsController.text.isEmpty ||
        _uasController.text.isEmpty) {
      _showError('Semua field harus diisi!');
      return;
    }

    final tugas = double.tryParse(_tugasController.text);
    final uts = double.tryParse(_utsController.text);
    final uas = double.tryParse(_uasController.text);

    if (tugas == null || uts == null || uas == null) {
      _showError('Semua nilai harus berupa angka!');
      return;
    }

    if (tugas > 100 || uts > 100 || uas > 100) {
      _showError('Nilai tidak boleh lebih dari 100!');
      return;
    }

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
