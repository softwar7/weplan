import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/theme/theme_provider.dart';

class ThemeSelectionPage extends StatelessWidget {
  const ThemeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('테마 선택'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ThemeMode.values[index].toString().split('.').last),
            onTap: () {
              context
                  .read<ThemeProvider>()
                  .setThemeMode(ThemeMode.values[index]);
              Navigator.pop(context);
            },
          );
        },
        separatorBuilder: (context, index) =>
            const Divider(height: 1, thickness: 0.1),
        itemCount: ThemeMode.values.length,
      ),
    );
  }
}
