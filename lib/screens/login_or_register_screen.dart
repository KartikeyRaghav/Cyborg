import 'package:cyborg/screens/login_screen.dart';
import 'package:cyborg/screens/register_screen.dart';
import 'package:flutter/material.dart';

class LoginorRegisterPage extends StatefulWidget {
  const LoginorRegisterPage({super.key});

  @override
  State<LoginorRegisterPage> createState() => _LoginorRegisterPageState();
}

class _LoginorRegisterPageState extends State<LoginorRegisterPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
