import 'package:flutter/material.dart';

class ModifyButton extends StatelessWidget {
  final Widget alertDialog;
  const ModifyButton({super.key, required this.alertDialog});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Column(
        children: [
          Icon(Icons.edit),
          Text('수정'),
        ],
      ),
      onPressed: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) {
            return this.alertDialog;
          },
        );
      },
    );
  }
}
