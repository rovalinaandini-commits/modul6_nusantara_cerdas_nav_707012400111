import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/pengajuan_model.dart';

class PengajuanCubit extends Cubit<List<Pengajuan>> {
  PengajuanCubit() : super([]);

  int get totalPengajuan => state.length;

  void tambahPengajuan(String namaLayanan) {
    tambahPengajuanLengkap(
      namaLayanan: namaLayanan,
      namaPemohon: '-',
      email: '-',
      sesi: '-',
    );
  }

  void tambahPengajuanLengkap({
    required String namaLayanan,
    required String namaPemohon,
    required String email,
    required String sesi,
  }) {
    final pengajuanBaru = Pengajuan(
      namaLayanan: namaLayanan,
      namaPemohon: namaPemohon,
      email: email,
      sesi: sesi,
    );

    emit([...state, pengajuanBaru]);
  }

  void hapusPengajuan(int index) {
    if (index < 0 || index >= state.length) return;

    final daftarBaru = List<Pengajuan>.from(state);
    daftarBaru.removeAt(index);
    emit(daftarBaru);
  }

  void tandaiSelesai(int index) {
    if (index < 0 || index >= state.length) return;

    state[index].tandaiSelesai();
    emit(List<Pengajuan>.from(state));
  }
}
