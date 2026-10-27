import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/pengajuan_cubit.dart';

class DetailLayananPage extends StatefulWidget {
  final Map<String, String> layanan;

  const DetailLayananPage({
    super.key,
    required this.layanan,
  });

  @override
  State<DetailLayananPage> createState() => _DetailLayananPageState();
}

class _DetailLayananPageState extends State<DetailLayananPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _setuju = false;
  bool _sedangMengajukan = false;
  String _sesiDipilih = 'Pagi';

  bool get _formValid {
    final namaTerisi = _namaController.text.trim().isNotEmpty;
    final email = _emailController.text.trim();
    final emailValid = email.contains('@') &&
        email.indexOf('@') > 0 &&
        email.indexOf('@') < email.length - 1;

    return namaTerisi && emailValid && _setuju;
  }

  @override
  void initState() {
    super.initState();

    _namaController.addListener(_perbaruiForm);
    _emailController.addListener(_perbaruiForm);
  }

  void _perbaruiForm() {
    setState(() {});
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    super.dispose();
  }


Future<void> _ajukanPermohonan() async {
  if (!_formValid || _sedangMengajukan) return;

  final namaLayanan = widget.layanan['nama'] ?? 'Layanan';

  setState(() {
    _sedangMengajukan = true;
  });

  // Simulasi proses pengiriman permohonan.
  await Future.delayed(const Duration(seconds: 2));

  if (!mounted) return;

  // Simpan nama layanan melalui PengajuanCubit.
  context.read<PengajuanCubit>().tambahPengajuan(namaLayanan);

  Navigator.pop(
    context,
    'Permohonan $namaLayanan telah diajukan',
  );
}

  @override
  Widget build(BuildContext context) {
    final email = _emailController.text.trim();
    final emailValid = email.contains('@') &&
        email.indexOf('@') > 0 &&
        email.indexOf('@') < email.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Layanan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.miscellaneous_services,
                  size: 45,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 25),

            Text(
              widget.layanan['nama'] ?? 'Nama Layanan',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),

            _infoLayanan(
              icon: Icons.account_balance,
              judul: 'Instansi Penanggung Jawab',
              isi: widget.layanan['dinas'] ?? '-',
            ),
            const SizedBox(height: 18),

            _infoLayanan(
              icon: Icons.access_time,
              judul: 'Jam Pelayanan',
              isi: widget.layanan['jam'] ?? '-',
            ),
            const SizedBox(height: 18),

            _infoLayanan(
              icon: Icons.info_outline,
              judul: 'Deskripsi',
              isi: widget.layanan['keterangan'] ?? '-',
            ),
            const SizedBox(height: 30),

            const Text(
              'Form Pengajuan Layanan',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lengkapi data berikut untuk mengajukan permohonan.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Input nama pemohon.
            TextField(
              controller: _namaController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                hintText: 'Masukkan nama lengkap',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),

            // Input dan validasi email.
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'contoh@email.com',
                prefixIcon: const Icon(Icons.email_outlined),
                border: const OutlineInputBorder(),
                errorText: email.isEmpty || emailValid
                    ? null
                    : 'Masukkan email yang mengandung @ dengan benar',
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Pilih Sesi Pelayanan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            // Pilihan sesi menggunakan state lokal.
            RadioListTile<String>(
              title: const Text('Pagi'),
              subtitle: const Text('08.00–10.00'),
              value: 'Pagi',
              groupValue: _sesiDipilih,
              activeColor: Colors.blue,
              contentPadding: EdgeInsets.zero,
              onChanged: _sedangMengajukan
                  ? null
                  : (value) {
                      if (value == null) return;
                      setState(() {
                        _sesiDipilih = value;
                      });
                    },
            ),
            RadioListTile<String>(
              title: const Text('Siang'),
              subtitle: const Text('10.00–13.00'),
              value: 'Siang',
              groupValue: _sesiDipilih,
              activeColor: Colors.blue,
              contentPadding: EdgeInsets.zero,
              onChanged: _sedangMengajukan
                  ? null
                  : (value) {
                      if (value == null) return;
                      setState(() {
                        _sesiDipilih = value;
                      });
                    },
            ),
            RadioListTile<String>(
              title: const Text('Sore'),
              subtitle: const Text('13.00–16.00'),
              value: 'Sore',
              groupValue: _sesiDipilih,
              activeColor: Colors.blue,
              contentPadding: EdgeInsets.zero,
              onChanged: _sedangMengajukan
                  ? null
                  : (value) {
                      if (value == null) return;
                      setState(() {
                        _sesiDipilih = value;
                      });
                    },
            ),

            const SizedBox(height: 12),

            // Persetujuan pemohon.
            CheckboxListTile(
              value: _setuju,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.blue,
              title: const Text(
                'Saya menyetujui data yang diberikan digunakan untuk '
                'keperluan pengajuan layanan.',
              ),
              onChanged: _sedangMengajukan
                  ? null
                  : (value) {
                      setState(() {
                        _setuju = value ?? false;
                      });
                    },
            ),

            const SizedBox(height: 24),

            // Tombol aktif jika nama, email, dan persetujuan valid.
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _formValid && !_sedangMengajukan
                    ? _ajukanPermohonan
                    : null,
                icon: _sedangMengajukan
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send),
                label: Text(
                  _sedangMengajukan
                      ? 'Mengajukan...'
                      : 'Ajukan Permohonan',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.blue.shade100,
                  disabledForegroundColor: Colors.grey.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoLayanan({
    required IconData icon,
    required String judul,
    required String isi,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 25),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  isi,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
