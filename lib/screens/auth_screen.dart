import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyborg/screens/Home_screen.dart';
import 'package:cyborg/screens/infromation_screen.dart';
import 'package:cyborg/screens/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User user = FirebaseAuth.instance.currentUser!;
            String uid = user.uid;
            CollectionReference userReference =
                FirebaseFirestore.instance.collection('users');
            bool info = false;
            userReference
                .doc(uid)
                .get()
                .then((DocumentSnapshot documentSnapshot) => {
                      if (documentSnapshot.exists)
                        {info = true}
                      else
                        {info = false}
                    });
            return info ? const HomeScreen() : const InformationPage();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something Went Wrong!!!'),
            );
          } else {
            return const OnBoardingScreen();
          }
        },
      ),
    );
  }
}
