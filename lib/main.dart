import 'package:flutter/material.dart';
import 'package:tic_tac_toe_flutter/Custom/custom_Colors.dart';
import 'package:tic_tac_toe_flutter/Pages/gameMode_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primaryColorDark: Colors.blue,
        scaffoldBackgroundColor: MyColors.azulFondo,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SelectGameMode(),
      },
    );
  }
}
