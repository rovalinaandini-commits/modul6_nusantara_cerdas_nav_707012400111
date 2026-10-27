import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system); //tema awal aplikasi akan mengikuti pengaturan tema perangkat pengguna,

  void toggle() { //fungsi mengganti tema ny
    emit(
      state == ThemeMode.dark //memeriksa apakah tema saat ini adalah mode gelap
          ? ThemeMode.light //kalau kondisinya benar (true), ubah ke mode terang
          : ThemeMode.dark, //kalau kondisinya salah (false), ubah ke mode gelap
    );
  }
}
