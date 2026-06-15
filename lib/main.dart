import 'package:flutter/material.dart';
//import 'state_module/state_provider.dart';
import 'movie_module/apps/movie_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return movieProvider ();
  }
}
