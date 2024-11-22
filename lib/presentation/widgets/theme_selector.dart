import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizmaster/core/models/theme.dart';

class ThemeSelector extends StatefulWidget {
  const ThemeSelector({Key? key}) : super(key: key);

  @override
  _ThemeSelectorState createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
  ThemeMode selectedThemeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final themeModel = Provider.of<ThemeModel>(context, listen: false);
      setState(() {
        selectedThemeMode = themeModel.themeMode;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ThemeMode>(
      segments: const <ButtonSegment<ThemeMode>>[
        ButtonSegment(
          value: ThemeMode.system,
          label: Text('System'),
        ),
        ButtonSegment(
          value: ThemeMode.light,
          label: Text('Light'),
        ),
        ButtonSegment(
          value: ThemeMode.dark,
          label: Text('Dark'),
        ),
      ],
      selected: <ThemeMode>{selectedThemeMode},
      onSelectionChanged: (Set<ThemeMode> newSelection) {
        final newTheme = newSelection.first;
        Provider.of<ThemeModel>(context, listen: false).toggleTheme(newTheme);
        setState(() {
          selectedThemeMode = newTheme;
        });
      },
    );
  }
}