import 'package:flutter/material.dart';

class DrawerSubjects extends StatelessWidget {
  final String title;
  const DrawerSubjects(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
      child: Text(
        this.title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
    // return const Placeholder();
  }
}
