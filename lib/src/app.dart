import 'package:flutter/material.dart';
import 'package:next/screens/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: const Color(0xFF151026)
          )
      ),
      home: HomeScreen(),
    );
  }
}