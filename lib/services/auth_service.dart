// ignore_for_file: use_build_context_synchronously

import 'package:cyborg/components/showBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      return await auth.signInWithCredential(credential).then((value) {
        User? user = FirebaseAuth.instance.currentUser;
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        showBar('Signed in as ${user?.email}', Icons.login, context);
      });
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      showBar(error.message!, Icons.error_outline, context);
    }
    Navigator.pop(context);
  }
}
