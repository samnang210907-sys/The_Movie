import 'package:flutter/material.dart';
import 'gridstyle_logic.dart';
import 'theme_logic.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final pic =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEva4-pTwf_5cgALddrMYRTLNTm8wM9AZFsw&s";

    bool dark = context.watch<ThemeLogic>().dark;
    bool gridStyle = context.watch<GridStyleLogic>().gridStyle;

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(pic),
            ), // CircleAvatar
          ), // Padding
          Divider(),
          Card(
            child: ListTile(
              leading: Icon(Icons.lightbulb),
              title: Text("Switched to ${dark ? "Dark" : "Light"} Mode"),
              trailing: Icon(dark ? Icons.dark_mode : Icons.light_mode),
              onTap: () {
                context.read<ThemeLogic>().toggleDark();
              },
            ), // ListTile
          ), // Card
          Card(
            child: ListTile(
              leading: Icon(Icons.style),
              title: Text("Switched to ${gridStyle ? "Grid" : "List"} Style"),
              trailing: Icon(gridStyle ? Icons.grid_view : Icons.list),
              onTap: () {
                context.read<GridStyleLogic>().toggleStyle();
              },
            ), // ListTile
          ), // Card
        ],
      ), // ListView
    ); // Scaffold
  }
}