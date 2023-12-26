import 'package:cyborg/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key, required this.iconData, required this.text});

  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      leading: Icon(
        iconData,
        color: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Theme.of(context).useMaterial3
                ? LineAwesomeIcons.moon
                : Icons.wb_sunny_rounded,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
        ),
      ],
      shadowColor: Colors.transparent,
    );
  }
}
