import 'package:flutter/material.dart';
import '../screens/parent_screen.dart';
import 'package:provider/provider.dart';

import '../logics/movie_gridstyle_logic.dart';
import '../logics/movie_theme_logic.dart';

class MovieSplashScreen extends StatefulWidget {
  const MovieSplashScreen({super.key});

  @override
  State<MovieSplashScreen> createState() => _MovieSplashScreenState();
}

class _MovieSplashScreenState extends State<MovieSplashScreen> {
  
  Future _loadData() async {
    await Future.delayed(Duration(seconds: 2), (){});
    if (mounted) {
      await context.read<MovieThemeLogic>().readTheme();
    }
    if (mounted) {
      await context.read<MovieGridstyleLogic>().readStyle();
    }
  }

  late Future _futureData = _loadData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 146, 55, 55),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.error.toString()),
                  FilledButton(
                    onPressed: () {
                      setState(() {
                        _futureData = _loadData();
                      });
                    },
                    child: Text("RETRY"),
                  ),
                ],
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ParentScreen();
        } else {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 146, 55, 55),
            body: Center(
              child: _buildLoading(),
            ),
          );
        }
      },
    );
  }

  Widget _buildLoading(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("images/Straw-Hat-Logo.png", height: 300,),
        ),
        CircularProgressIndicator(color: Colors.white,),
      ],
    );
  }

}
