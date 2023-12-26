import 'package:flutter/material.dart';

class MyProfileIcon extends StatelessWidget {
  const MyProfileIcon(
      {super.key,
      required this.iconData,
      required this.text,
      required this.onPress,
      this.endIcon = true,
      this.textColor});

  final IconData iconData;
  final String text;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
        child: Icon(
          iconData,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
            color: textColor ?? Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              ),
              child: Icon(
                Icons.chevron_right_rounded,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
            )
          : null,
    );
  }
}
