import 'package:flutter/material.dart';
import 'OderPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 58, 146, 183)),
        useMaterial3: true,

      ),
      home: const OderPage(title: 'タイトル'),
    );
  }
}
