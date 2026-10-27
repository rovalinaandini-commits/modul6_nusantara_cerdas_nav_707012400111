import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../navigation/app_routes.dart';

class LayananPage extends StatelessWidget {
  const LayananPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Layanan Publik',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Pilih layanan publik sesuai kebutuhan Anda.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.description_outlined),
                text: 'Perizinan',
              ),
              Tab(
                icon: Icon(Icons.local_hospital_outlined),
                text: 'Kesehatan',
              ),
              Tab(
                icon: Icon(Icons.directions_bus_outlined),
                text: 'Transportasi',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _daftarPerizinan(),
                _daftarKesehatan(),
                _daftarTransportasi(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _daftarPerizinan() {
    final layanan = <Map<String, String>>[
      {
        'nama': 'Izin Usaha',
        'dinas': 'Dinas Penanaman Modal dan Pelayanan Terpadu',
        'jam': '08.00 - 15.00',
        'keterangan':
            'Layanan pengajuan izin usaha bagi masyarakat dan pelaku usaha.',
      },
      {
        'nama': 'Izin Bangunan',
        'dinas': 'Dinas Pekerjaan Umum dan Tata Ruang',
        'jam': '08.00 - 15.00',
        'keterangan':
            'Layanan pengurusan izin pembangunan dan renovasi bangunan.',
      },
      {
        'nama': 'Izin Keramaian',
        'dinas': 'Dinas Perizinan Kota',
        'jam': '08.00 - 14.00',
        'keterangan':
            'Layanan pengajuan izin untuk kegiatan masyarakat yang melibatkan banyak peserta.',
      },
    ];

    return _buatDaftarLayanan(layanan);
  }

  Widget _daftarKesehatan() {
    final layanan = <Map<String, String>>[
      {
        'nama': 'Pendaftaran Puskesmas',
        'dinas': 'Dinas Kesehatan Kota',
        'jam': '07.30 - 14.00',
        'keterangan':
            'Layanan pendaftaran kunjungan masyarakat ke puskesmas.',
      },
      {
        'nama': 'Layanan Ambulans',
        'dinas': 'Dinas Kesehatan Kota',
        'jam': '24 Jam',
        'keterangan':
            'Layanan bantuan transportasi medis untuk kondisi darurat.',
      },
      {
        'nama': 'Jadwal Vaksinasi',
        'dinas': 'Dinas Kesehatan Kota',
        'jam': '08.00 - 14.00',
        'keterangan':
            'Informasi jadwal dan lokasi pelayanan vaksinasi masyarakat.',
      },
    ];

    return _buatDaftarLayanan(layanan);
  }

  Widget _daftarTransportasi() {
    final layanan = <Map<String, String>>[
      {
        'nama': 'Kartu Transportasi',
        'dinas': 'Dinas Perhubungan Kota',
        'jam': '08.00 - 15.00',
        'keterangan':
            'Layanan pendaftaran dan pengelolaan kartu transportasi warga.',
      },
      {
        'nama': 'Pengaduan Transportasi',
        'dinas': 'Dinas Perhubungan Kota',
        'jam': '08.00 - 16.00',
        'keterangan':
            'Layanan untuk menyampaikan pengaduan terkait transportasi umum.',
      },
      {
        'nama': 'Informasi Rute',
        'dinas': 'Dinas Perhubungan Kota',
        'jam': '24 Jam',
        'keterangan':
            'Informasi mengenai rute dan jadwal transportasi umum.',
      },
    ];

    return _buatDaftarLayanan(layanan);
  }

  Widget _buatDaftarLayanan(
    List<Map<String, String>> layanan,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: layanan.length,
      itemBuilder: (context, index) {
        final item = layanan[index];
        final namaLayanan = item['nama']!;

        return Card(
          margin: const EdgeInsets.only(bottom: 14),
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
                Icons.miscellaneous_services,
                color: Colors.blue,
              ),
            ),
            title: Text(
              namaLayanan,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(item['dinas']!),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<FavoritCubit, Set<String>>(
                  builder: (context, daftarFavorit) {
                    final isFavorit =
                        daftarFavorit.contains(namaLayanan);

                    return IconButton(
                      tooltip: isFavorit
                          ? 'Hapus dari favorit'
                          : 'Tambah ke favorit',
                      icon: Icon(
                        isFavorit ? Icons.star : Icons.star_border,
                        color: isFavorit
                            ? Colors.amber
                            : Colors.grey,
                      ),
                      onPressed: () {
                        context
                            .read<FavoritCubit>()
                            .ubahFavorit(namaLayanan);
                      },
                    );
                  },
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ],
            ),
            onTap: () async {
              final hasil = await Navigator.pushNamed(
                context,
                AppRoutes.detailLayanan,
                arguments: item,
              );

              if (hasil != null && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(hasil.toString()),
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
