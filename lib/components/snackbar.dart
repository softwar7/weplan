import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, {Icon? icon}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if (icon != null) icon,
          const SizedBox(width: 10),
          Flexible(
            child: Text(message),
          ),
        ],
      ),
    ),
  );
}

void showErrorSnackBar(BuildContext context, String message) {
  showSnackBar(
    context,
    message,
    icon: const Icon(
      Icons.error_outline,
      color: Colors.red,
    ),
  );
}
