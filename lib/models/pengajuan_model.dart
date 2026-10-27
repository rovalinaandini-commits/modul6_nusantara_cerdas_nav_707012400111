import 'package:flutter/foundation.dart';

class Pengajuan {
  final String namaLayanan;
  final String namaPemohon;
  final String email;
  final String sesi;
  String status;

  Pengajuan({
    required this.namaLayanan,
    required this.namaPemohon,
    required this.email,
    required this.sesi,
    this.status = 'Menunggu',
  });

  void tandaiSelesai() {
    status = 'Selesai';
  }
}

class PengajuanModel extends ChangeNotifier {
  final List<Pengajuan> _daftarPengajuanDetail = [];

  // Dipertahankan agar kode halaman lama yang memakai daftarPengajuan
  // tetap bisa berjalan.
  List<String> get daftarPengajuan => _daftarPengajuanDetail
      .map((pengajuan) => pengajuan.namaLayanan)
      .toList();

  List<Pengajuan> get daftarPengajuanDetail =>
      List.unmodifiable(_daftarPengajuanDetail);

  int get totalPengajuan => _daftarPengajuanDetail.length;

  // Metode lama tetap tersedia untuk menjaga kompatibilitas.
  void tambahPengajuan(String namaLayanan) {
    _daftarPengajuanDetail.add(
      Pengajuan(
        namaLayanan: namaLayanan,
        namaPemohon: '-',
        email: '-',
        sesi: '-',
      ),
    );
    notifyListeners();
  }

  // Metode baru untuk menyimpan data dari form.
  void tambahPengajuanLengkap({
    required String namaLayanan,
    required String namaPemohon,
    required String email,
    required String sesi,
  }) {
    _daftarPengajuanDetail.add(
      Pengajuan(
        namaLayanan: namaLayanan,
        namaPemohon: namaPemohon,
        email: email,
        sesi: sesi,
      ),
    );
    notifyListeners();
  }

  void tandaiSelesai(int index) {
    if (index < 0 || index >= _daftarPengajuanDetail.length) return;

    _daftarPengajuanDetail[index].tandaiSelesai();
    notifyListeners();
  }
}
