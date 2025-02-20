import 'package:flutter/material.dart';
import 'boss_list_screen.dart';
import 'stats_screen.dart';
import 'search_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  Widget _getScreen() {
    switch (_selectedIndex) {
      case 0:
        return const BossListScreen();
      case 1:
        return const SearchScreen();
      case 2:
        return const StatsScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const BossListScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.people),
            label: 'Boss',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
} 