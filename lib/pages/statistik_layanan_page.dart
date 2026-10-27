import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../models/pengajuan_model.dart';

class StatistikLayananPage extends StatelessWidget {
  const StatistikLayananPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PengajuanCubit, List<Pengajuan>>(
      builder: (context, pengajuan) {
        final jumlahMenunggu = pengajuan
            .where((item) => item.status == 'Menunggu')
            .length;

        final jumlahSelesai = pengajuan
            .where((item) => item.status == 'Selesai')
            .length;

        final total = pengajuan.length;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Statistik Layanan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ringkasan Pengajuan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _KartuStatistik(
                        judul: 'Total Pengajuan',
                        jumlah: total,
                        warna: Colors.blue,
                        ikon: Icons.description_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _KartuStatistik(
                        judul: 'Menunggu',
                        jumlah: jumlahMenunggu,
                        warna: Colors.orange,
                        ikon: Icons.hourglass_empty,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _KartuStatistik(
                  judul: 'Selesai',
                  jumlah: jumlahSelesai,
                  warna: Colors.green,
                  ikon: Icons.check_circle_outline,
                ),
                const SizedBox(height: 28),
                const Text(
                  'Grafik Status Pengajuan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Grafik menunjukkan jumlah pengajuan berdasarkan statusnya.',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 280,
                  child: BarChart(
                    BarChartData(
                      minY: 0,
                      maxY: _batasAtas(
                        jumlahMenunggu,
                        jumlahSelesai,
                      ).toDouble(),
                      alignment: BarChartAlignment.spaceEvenly,
                      barGroups: [
                        _buatGrup(0, jumlahMenunggu, Colors.orange),
                        _buatGrup(1, jumlahSelesai, Colors.green),
                      ],
                      gridData: const FlGridData(show: true),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 36,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              String judul;

                              if (value.toInt() == 0) {
                                judul = 'Menunggu';
                              } else if (value.toInt() == 1) {
                                judul = 'Selesai';
                              } else {
                                judul = '';
                              }

                              return SideTitleWidget(
                                meta: meta,
                                child: Text(
                                  judul,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (total == 0)
                  const Center(
                    child: Text(
                      'Belum ada pengajuan untuk ditampilkan.',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  static int _batasAtas(int menunggu, int selesai) {
    final terbesar = menunggu > selesai ? menunggu : selesai;
    return terbesar == 0 ? 5 : terbesar + 2;
  }

  static BarChartGroupData _buatGrup(
    int x,
    int jumlah,
    Color warna,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: jumlah.toDouble(),
          color: warna,
          width: 38,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(6),
          ),
        ),
      ],
    );
  }
}

class _KartuStatistik extends StatelessWidget {
  final String judul;
  final int jumlah;
  final Color warna;
  final IconData ikon;

  const _KartuStatistik({
    required this.judul,
    required this.jumlah,
    required this.warna,
    required this.ikon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(ikon, color: warna, size: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$jumlah',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: warna,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
