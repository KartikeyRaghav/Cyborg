// ignore_for_file: file_names

import 'package:flutter/material.dart';

showBar(String text, IconData iconData, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      content: Row(
        children: [
          Icon(
            iconData,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
