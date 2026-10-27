import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit() : super(<String>{});

  void tandai(String namaLayanan) {
    final favoritBaru = Set<String>.from(state);
    favoritBaru.add(namaLayanan);
    emit(favoritBaru);
  }

  void batalTandai(String namaLayanan) {
    final favoritBaru = Set<String>.from(state);
    favoritBaru.remove(namaLayanan);
    emit(favoritBaru);
  }

  void ubahFavorit(String namaLayanan) {
    if (state.contains(namaLayanan)) {
      batalTandai(namaLayanan);
    } else {
      tandai(namaLayanan);
    }
  }
}
