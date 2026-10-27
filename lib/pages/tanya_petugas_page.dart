import 'package:flutter/material.dart';

class TanyaPetugasPage extends StatefulWidget {
  const TanyaPetugasPage({super.key});

  @override
  State<TanyaPetugasPage> createState() => _TanyaPetugasPageState();
}

class _TanyaPetugasPageState extends State<TanyaPetugasPage> {
  final TextEditingController _pesanController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, String>> _daftarPesan = [
    {
      'pengirim': 'petugas',
      'pesan': 'Halo! Selamat datang di layanan Tanya Petugas. '
          'Ada yang bisa kami bantu?',
    },
  ];

  void _kirimPesan() {
    final teks = _pesanController.text.trim();

    if (teks.isEmpty) return;

    setState(() {
      _daftarPesan.add({
        'pengirim': 'warga',
        'pesan': teks,
      });
      _pesanController.clear();
    });

    // Gulir ke pesan terbaru.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pesanController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tanya Petugas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Informasi bahwa chat masih berupa simulasi.
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.blue.shade50,
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Simulasi chat. Pesan belum dikirim ke petugas sungguhan.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),

          // Daftar percakapan.
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _daftarPesan.length,
              itemBuilder: (context, index) {
                final pesan = _daftarPesan[index];
                final dariWarga = pesan['pengirim'] == 'warga';

                return Align(
                  alignment: dariWarga
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: dariWarga
                          ? Colors.blue
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(14),
                        topRight: const Radius.circular(14),
                        bottomLeft: Radius.circular(dariWarga ? 14 : 0),
                        bottomRight: Radius.circular(dariWarga ? 0 : 14),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dariWarga ? 'Anda' : 'Petugas',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: dariWarga
                                ? Colors.white70
                                : Colors.blue.shade800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          pesan['pesan'] ?? '',
                          style: TextStyle(
                            color: dariWarga ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Kolom input dan tombol kirim.
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _pesanController,
                      minLines: 1,
                      maxLines: 4,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _kirimPesan(),
                      decoration: InputDecoration(
                        hintText: 'Tulis pesan...',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _kirimPesan,
                    tooltip: 'Kirim pesan',
                    icon: const Icon(Icons.send),
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
