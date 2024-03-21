import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_testing/page/animals2_page.dart';
import 'package:provider_testing/page/animals_page.dart';
import 'package:provider_testing/page/person_page.dart';
import 'package:provider_testing/provider/animals2_provider.dart';
import 'package:provider_testing/provider/counter_provider.dart';
import 'package:provider_testing/page/counter_page.dart';
import 'package:provider_testing/provider/person_provider.dart';
import 'package:provider_testing/provider/todo_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => TodoProvider()),
        ChangeNotifierProvider(create: (context) => PersonProvider()),
        ChangeNotifierProvider(create: (context) => Animals2Provider()),
        // Tambahkan provider lain di sini jika diperlukan
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Animals2Page(),
    );
  }
}
