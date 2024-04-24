import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../meals/meal_data.dart';
import 'pages/main_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("meal_database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MealsData(),
      child: MaterialApp(
        title: 'Dyet Your Way',
        theme:
        ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Dyet Your Way'),
      ),
    );
  }
}
