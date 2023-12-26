// ignore_for_file: must_be_immutable

import 'package:cyborg/components/palette.dart';
import 'package:flutter/material.dart';

class NewsDisplayPage extends StatelessWidget {
  const NewsDisplayPage({
    super.key,
    required this.news,
  });

  final Map news;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    news['title'],
                    style: const TextStyle(
                      fontSize: 22,
                      color: Palette.red,
                      decoration: TextDecoration.none,
                      fontFamily: 'Nunito',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  news['description'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                    decoration: TextDecoration.none,
                    fontFamily: 'Nunito',
                  ),
                  textAlign: TextAlign.justify,
                ),
                Text(
                  news['content'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                    decoration: TextDecoration.none,
                    fontFamily: 'Nunito',
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
