// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cyborg/components/my_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyborg/components/my_profile_icon.dart';
import 'package:cyborg/components/showBar.dart';
import 'package:cyborg/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User user = FirebaseAuth.instance.currentUser!;
  String dob = '';
  var userList;

  @override
  Widget build(BuildContext context) {
    CollectionReference userReference =
        FirebaseFirestore.instance.collection('users');

    getUser() async {
      await userReference.doc(user.uid).get().then((value) {
        var data = value.data() as Map<String, dynamic>;
        userList = data;
      });
    }

    userReference.doc(user.uid).get().then((value) {
      var data = value.data() as Map<String, dynamic>;
      userList = data;
    });
    getUser();
    return Scaffold(
      body: FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 111,
                  ),
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    child: Column(
                      children: [
                        const MyAppBar(
                          iconData: Icons.person,
                          text: 'Profile',
                        ),
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: userList != null
                                ? Image.network(userList['image'])
                                : Image.asset('assets/logo.png'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          userList != null ? userList['name'] : 'Fetching...',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${user.email}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          userList != null
                              ? userList['mobile'].toString()
                              : 'Fetching...',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 60,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                              showBar('Feature under development', Icons.info,
                                  context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              side: BorderSide.none,
                              shape: const StadiumBorder(),
                            ),
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            children: [
                              MyProfileIcon(
                                iconData: Icons.settings,
                                text: 'Settings',
                                onPress: () {
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                  showBar('Feature under development',
                                      Icons.info, context);
                                },
                              ),
                              MyProfileIcon(
                                iconData: Icons.logout_rounded,
                                text: 'Logout',
                                onPress: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const OnBoardingScreen(),
                                    ),
                                  );
                                },
                                endIcon: false,
                                textColor: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget getBody() {
}
