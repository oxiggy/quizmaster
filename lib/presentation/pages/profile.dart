import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmaster/core/models/theme.dart';
import 'package:quizmaster/core/utils/debug_utils.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text('Profile', style: TextStyle(fontSize: 30)),
            ),
            PopupMenuButton<ThemeMode>(
              onSelected: (ThemeMode selectedMode) {
                Provider.of<ThemeModel>(context, listen: false).toggleTheme(selectedMode);
              },
              icon: const Icon(Icons.color_lens),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: ThemeMode.light,
                  child: Text('light theme'),
                ),
                const PopupMenuItem(
                  value: ThemeMode.dark,
                  child: Text('dark theme'),
                ),
                const PopupMenuItem(
                  value: ThemeMode.system,
                  child: Text('system theme'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  printAllSharedPreferences();
                },
                child: Text('Print all shared preferences'),
            )
          ]
        )
      ),
    );
  }
}