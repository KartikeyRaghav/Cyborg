// ignore_for_file: file_names, must_be_immutable

import 'package:cyborg/screens/pages/complain_page.dart';
import 'package:cyborg/screens/pages/profile_page.dart';
import 'package:cyborg/screens/pages/learn_page.dart';
import 'package:cyborg/screens/pages/news_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageNo = 0;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      child: Scaffold(
        body: IndexedStack(
          index: pageNo,
          children: const [
            HomePage(),
            NewsPage(),
            LearnPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.inverseSurface,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: GNav(
              onTabChange: (index) {
                setState(() {
                  pageNo = index;
                });
              },
              backgroundColor: Theme.of(context).colorScheme.inverseSurface,
              color: Theme.of(context).colorScheme.tertiary,
              activeColor: Theme.of(context).colorScheme.background,
              tabBackgroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.all(16),
              gap: 8,
              tabs: const [
                GButton(
                  icon: Icons.description_rounded,
                  text: 'Complaint',
                ),
                GButton(
                  icon: Icons.document_scanner_outlined,
                  text: 'News',
                ),
                GButton(
                  icon: Icons.menu_book_rounded,
                  text: 'Learn',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
