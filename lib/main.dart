import 'package:flutter/material.dart';

import 'screen/home_screen.dart';

void main() {
  print("");
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
