import 'package:flutter/material.dart';
import 'package:status_usage/Pages/help.dart';
import 'package:status_usage/Pages/home.dart';
import 'package:status_usage/Pages/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'System Monitor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/home': (context) => const Home(),
        '/settings': (context) => const Settings(),
        '/help': (context) => Help()
      },
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(useMaterial3: true),
      home: const Home(),
    );
  }
}
