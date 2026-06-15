import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'setting_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: HomeScreen(),
          item: ItemConfig(
            icon: Icon(Icons.home),
            title: "Home",
            activeForegroundColor: Theme.of(context).colorScheme.primary,
          ),
        ), // PersistentTabConfig
        PersistentTabConfig(
          screen: const SearchScreen(),
          item: ItemConfig(
            icon: Icon(Icons.search),
            title: "Search",
            activeForegroundColor: Theme.of(context).colorScheme.primary,
          ),
        ), // PersistentTabConfig
        PersistentTabConfig(
          screen: const SettingsScreen(),
          item: ItemConfig(
            icon: Icon(Icons.settings),
            title: "Settings",
            activeForegroundColor: Theme.of(context).colorScheme.primary,
          ),
        ), // PersistentTabConfig
      ],
      navBarBuilder: (NavBarConfig p1) {
        return Style1BottomNavBar(
          navBarConfig: p1,
          navBarDecoration: NavBarDecoration(
            color: Theme.of(context).colorScheme.onInverseSurface,
          ), // NavBarDecoration
        ); // Style1BottomNavBar
      },
    ); // PersistentTabView
  }
}