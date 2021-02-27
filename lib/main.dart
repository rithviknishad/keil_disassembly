import 'package:flutter/material.dart';
import 'package:keil_disassembly/routes/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const _primary = Color.fromARGB(255, 0, 38, 70);
  static const _accent = Color.fromARGB(255, 245, 248, 253);
  static const _secondary = Color(0xFFFFCA28);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Keil Disassembly Tool by rithviknishad',
      theme: ThemeData(
        fontFamily: 'CascadiaCode',
        brightness: Brightness.light,
        primaryColor: _primary,
        accentColor: _accent,
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: Colors.white,
          actionsIconTheme: const IconThemeData(color: _primary),
        ),
        iconTheme: const IconThemeData(color: _primary),

        scaffoldBackgroundColor: _accent,
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: _primary,
          actionTextColor: _secondary,
          disabledActionTextColor: Colors.grey,
          contentTextStyle: TextStyle(color: Colors.white),
        ),

        // Bottom Navigation Bar Theme
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: _primary,
          selectedItemColor: _secondary,
          unselectedItemColor: Colors.blueGrey,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: _accent,
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: _primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red),
          ),
          labelStyle: const TextStyle(color: _primary, fontSize: 14),
          focusColor: _primary,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
      },
    );
  }
}
