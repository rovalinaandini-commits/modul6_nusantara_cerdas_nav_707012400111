import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../models/pengajuan_model.dart';

class RiwayatLaporanPage extends StatefulWidget {
  const RiwayatLaporanPage({super.key});

  @override
  State<RiwayatLaporanPage> createState() =>
      _RiwayatLaporanPageState();
}

class _RiwayatLaporanPageState extends State<RiwayatLaporanPage> {
  String _filterStatus = 'Semua';

  void _tampilkanDetail(Pengajuan pengajuan) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Detail Pengajuan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama Layanan: ${pengajuan.namaLayanan}'),
              const SizedBox(height: 8),
              Text('Nama Pemohon: ${pengajuan.namaPemohon}'),
              const SizedBox(height: 8),
              Text('Email: ${pengajuan.email}'),
              const SizedBox(height: 8),
              Text('Sesi: ${pengajuan.sesi}'),
              const SizedBox(height: 8),
              Text('Status: ${pengajuan.status}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Laporan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<PengajuanCubit, List<Pengajuan>>(
        builder: (context, daftarPengajuan) {
          final pengajuanTampil = daftarPengajuan.where((item) {
            if (_filterStatus == 'Semua') return true;
            return item.status == _filterStatus;
          }).toList();

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Riwayat Pengajuan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Daftar layanan yang pernah Anda ajukan.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              if (pengajuanTampil.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 45),
                  child: Column(
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 65,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _filterStatus == 'Semua'
                            ? 'Belum ada pengajuan layanan.'
                            : 'Belum ada pengajuan berstatus $_filterStatus.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Pengajuan dari form akan muncul di sini.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
              else
                ...pengajuanTampil.reversed.map((pengajuan) {
                  final selesai = pengajuan.status == 'Selesai';

                  return Card(
                    margin: const EdgeInsets.only(bottom: 15),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue.withAlpha(25),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.miscellaneous_services,
                          color: Colors.blue,
                        ),
                      ),
                      title: Text(
                        pengajuan.namaLayanan,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Status: ${pengajuan.status}',
                          style: TextStyle(
                            color: selesai ? Colors.green : Colors.orange,
                          ),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                      onTap: () => _tampilkanDetail(pengajuan),
                    ),
                  );
                }),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Buka halaman layanan untuk membuat pengajuan baru.',
              ),
            ),
          );
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _tombolFilter(
                ikon: Icons.list,
                status: 'Semua',
                tooltip: 'Semua Pengajuan',
              ),
              _tombolFilter(
                ikon: Icons.pending_actions,
                status: 'Menunggu',
                tooltip: 'Menunggu',
              ),
              _tombolFilter(
                ikon: Icons.check_circle_outline,
                status: 'Selesai',
                tooltip: 'Selesai',
              ),
              IconButton(
                onPressed: () {
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Daftar pengajuan diperbarui.'),
                    ),
                  );
                },
                icon: const Icon(Icons.refresh),
                tooltip: 'Refresh',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tombolFilter({
    required IconData ikon,
    required String status,
    required String tooltip,
  }) {
    return IconButton(
      onPressed: () {
        setState(() => _filterStatus = status);
      },
      icon: Icon(
        ikon,
        color: _filterStatus == status ? Colors.blue : Colors.grey,
      ),
      tooltip: tooltip,
    );
  }
}
