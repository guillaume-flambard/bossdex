import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/preferences_service.dart';
import '../services/notification_service.dart';
import '../models/user_preferences.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserPreferences _preferences;
  final _nameController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await PreferencesService.getPreferences();
    setState(() {
      _preferences = prefs;
      _nameController.text = prefs.userName ?? '';
      _isLoading = false;
    });
  }

  Future<void> _savePreferences() async {
    await PreferencesService.savePreferences(_preferences);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Profil',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Préférences',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nom d\'utilisateur',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _preferences = _preferences.copyWith(userName: value);
                      _savePreferences();
                    },
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Mode sombre'),
                    value: _preferences.isDarkMode,
                    onChanged: (value) async {
                      setState(() {
                        _preferences = _preferences.copyWith(isDarkMode: value);
                      });
                      await _savePreferences();
                      if (!mounted) return;
                      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Notifications'),
                    value: _preferences.notificationsEnabled,
                    onChanged: (value) async {
                      if (value) {
                        final permitted = await NotificationService.requestPermission();
                        if (!permitted) return;
                      }
                      setState(() {
                        _preferences = _preferences.copyWith(notificationsEnabled: value);
                        _savePreferences();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 