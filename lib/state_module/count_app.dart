import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter_logic.dart';
import 'theme_logic.dart';
import 'main_screen.dart';

class CountApp extends StatelessWidget {
  const CountApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    bool dark = context.watch<ThemeLogic>().dark;
    Color seedColor = const Color.fromARGB(255, 132, 29, 24);

    double size = context.watch<CounterLogic>().counter.toDouble();

    

    return MaterialApp(
      
      home: MainScreen(),
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16 + size),
        )
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16 + size),
        )
      ),
    );
  }
}