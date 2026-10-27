import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/favorit_cubit.dart';
import '../navigation/app_routes.dart';
import '../cubit/theme_cubit.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Warga',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Kelola aktivitas dan layanan Anda sebagai warga.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 25),

          // =========================
          // Kartu Profil
          // =========================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 35,
                    color: Colors.blue,
                  ),
                ),

                SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rovalina Andini',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Pengguna Aplikasi',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),


          // =========================
          // Pengaturan Tema
          // =========================
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              final temaGelap = themeMode == ThemeMode.dark;

              return Card(
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
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      temaGelap
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimaryContainer,
                    ),
                  ),
                  title: const Text(
                    'Pengaturan Tema',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    temaGelap
                        ? 'Mode gelap sedang aktif'
                        : themeMode == ThemeMode.system
                            ? 'Mengikuti tema perangkat'
                            : 'Mode terang sedang aktif',
                  ),
                  trailing: Switch(
                    value: temaGelap,
                    onChanged: (_) {
                      context.read<ThemeCubit>().toggle();
                    },
                  ),
                ),
              );
            },
          ),


          const SizedBox(height: 30),

          const Text(
            'Aktivitas Warga',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          // =========================
          // Riwayat Laporan
          // =========================
          Card(
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
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.history,
                  color: Colors.blue,
                ),
              ),
              title: const Text(
                'Riwayat Laporan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'Lihat laporan dan pengaduan yang pernah Anda kirim.',
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.riwayatLaporan,
                );
              },
            ),
          ),

          const SizedBox(height: 14),

          // =========================
          // Pengaduan Warga
          // =========================
          Card(
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
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.report_problem_outlined,
                  color: Colors.orange,
                ),
              ),
              title: const Text(
                'Pengaduan Warga',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'Sampaikan permasalahan yang terjadi di lingkungan kota.',
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Fitur pengaduan warga akan segera tersedia.',
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 14),

          // =========================
          // Informasi Warga
          // =========================
          Card(
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
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.green,
                ),
              ),
              title: const Text(
                'Informasi Warga',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'Informasi dan layanan yang tersedia untuk warga.',
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Informasi warga tersedia pada aplikasi Nusantara Cerdas.',
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          // =========================
          // Layanan Favorit
          // =========================
          const Text(
            'Layanan Favorit',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),


BlocBuilder<FavoritCubit, Set<String>>(
  builder: (context, daftarFavorit) {
    final daftar = daftarFavorit.toList();

    if (daftar.isEmpty) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                Icons.star_border,
                color: Colors.grey,
                size: 30,
              ),
              SizedBox(width: 14),
              Expanded(
                child: Text(
                  'Belum ada layanan yang ditandai sebagai favorit.',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: daftar.map((namaLayanan) {
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
            title: Text(
              namaLayanan,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                'Layanan yang Anda tandai sebagai favorit.',
              ),
            ),
            trailing: IconButton(
              tooltip: 'Hapus dari favorit',
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {
                context
                    .read<FavoritCubit>()
                    .batalTandai(namaLayanan);
              },
            ),
          ),
        );
      }).toList(),
    );
  },
),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}