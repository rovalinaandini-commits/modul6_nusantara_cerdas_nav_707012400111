import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LokasiKantorPage extends StatefulWidget {
  const LokasiKantorPage({super.key});

  @override
  State<LokasiKantorPage> createState() => _LokasiKantorPageState();
}

class _LokasiKantorPageState extends State<LokasiKantorPage> {
  // Contoh koordinat untuk demonstrasi di wilayah Bandung.
  // Sesuaikan dengan lokasi kantor yang benar jika data tersedia.
  static const LatLng _pusatPeta = LatLng(-6.9147, 107.6098);

  final Set<Marker> _markers = {
    Marker(
      markerId: const MarkerId('kantor_1'), 
      position: const LatLng(-6.9147, 107.6098),
      infoWindow: const InfoWindow(
        title: 'Kantor Dishub Kota Bandung',
        snippet: 'Dinas Perhubungan Kota Bandung',
      ),
    ),
    Marker(
      markerId: const MarkerId('kantor_2'),
      position: const LatLng(-6.9039, 107.6186),
      infoWindow: const InfoWindow(
        title: 'Kantor Disdukcapil Kota Bandung',
        snippet: 'Dinas Kependudukan dan Pencatatan Sipil Kota Bandung',
      ),
    ),
    Marker(
      markerId: const MarkerId('kantor_3'),
      position: const LatLng(-6.9267, 107.6067),
      infoWindow: const InfoWindow(
        title: 'Kantor Imigrasi',
        snippet: 'Kantor Imigrasi Kota Bandung',
      ),
    ),
  };

  GoogleMapController? _mapController;

  Future<void> _fokusKantor(LatLng posisi) async {
    await _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(posisi, 15),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lokasi Kantor',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: _pusatPeta,
                zoom: 13,
              ),
              markers: _markers,
              onMapCreated: (controller) {
                _mapController = controller;
              },
              mapToolbarEnabled: true,
              zoomControlsEnabled: true,
              myLocationButtonEnabled: false,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: const Text(
              'Daftar Kantor Pelayanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ..._markers.map((marker) {
            return ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.location_on, color: Colors.white),
              ),
              title: Text(marker.infoWindow.title ?? 'Kantor Pelayanan'),
              subtitle: Text(marker.infoWindow.snippet ?? ''),
              trailing: const Icon(Icons.map_outlined),
              onTap: () => _fokusKantor(marker.position),
            );
          }),
        ],
      ),
    );
  }
}
