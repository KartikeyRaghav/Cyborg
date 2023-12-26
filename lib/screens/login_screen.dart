// ignore_for_file: use_build_context_synchronously

import 'package:cyborg/components/my_button.dart';
import 'package:cyborg/components/my_text_field.dart';
import 'package:cyborg/components/palette.dart';
import 'package:cyborg/components/showBar.dart';
import 'package:cyborg/components/square_tile.dart';
import 'package:cyborg/screens/Home_screen.dart';
import 'package:cyborg/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      )
          .then((value) async {
        User? user = FirebaseAuth.instance.currentUser;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        showBar('Signed in as ${user?.email}', Icons.login, context);
      });
    } on FirebaseAuthException catch (error) {
      if (error.code == 'channel-error') {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        showBar('Please fill the email and password field', Icons.error_outline,
            context);
      } else if (error.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        showBar('Invalid Credentials', Icons.error_outline, context);
      } else {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        showBar(error.message!, Icons.error_outline, context);
      }
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_person_rounded,
                  size: 100,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(height: 10),
                Text(
                  'Welcome back you\'ve been missed',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: emailcontroller,
                  hintText: 'Email-ID',
                  obscureText: false,
                  type: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                MyTextField(
                  controller: passwordcontroller,
                  hintText: 'Password',
                  obscureText: true,
                  type: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        showBar(
                            'Feature under development', Icons.info, context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 25.0),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Palette.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                MyButton(onTap: signUserIn, text: 'Sign In'),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or Continue with',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      imagePath: 'assets/google.png',
                      onTap: () => AuthService().signInWithGoogle(context),
                    ),
                    const SizedBox(width: 20),
                    SquareTile(
                      imagePath: 'assets/apple.png',
                      onTap: () {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        showBar(
                            'Feature under development', Icons.info, context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member?',
                      style: TextStyle(
                        color: Palette.secondary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
