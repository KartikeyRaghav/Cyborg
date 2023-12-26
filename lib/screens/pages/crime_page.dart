// ignore_for_file: must_be_immutable

// import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyborg/components/palette.dart';
import 'package:flutter/material.dart';

class CrimePage extends StatelessWidget {
  CrimePage({
    super.key,
    required this.list,
    required this.title,
  });

  final List list;
  final String title;
  Map crimes = {};

  List values = [];
  getCrimes() async {
    CollectionReference crimeReference =
        FirebaseFirestore.instance.collection('crimes');
    await crimeReference.where('title', isEqualTo: title).get().then((value) {
      for (var element in value.docs) {
        var data = element.data() as Map<String, dynamic>;
        crimes = data;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    values = [];
    return SafeArea(
      child: FutureBuilder(
        future: getCrimes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Something went wrong",
                style: TextStyle(
                  fontSize: 40,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Nunito',
                  decoration: TextDecoration.none,
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
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
                          crimes['title'],
                          style: const TextStyle(
                            fontSize: 40,
                            color: Palette.red,
                            decoration: TextDecoration.none,
                            fontFamily: 'Nunito',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: List.generate(
                          crimes['questions'].length,
                          (index) => Column(
                            children: [
                              Text(
                                crimes['questions'][index]['question'],
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 30,
                                  color: Theme.of(context).colorScheme.tertiary,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: List.generate(
                                  crimes['questions'][index]['answer'].length,
                                  (i) => Text(
                                    crimes['questions'][index]['answer'][i],
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 18,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              crimes['questions'][index]['list'] != null
                                  ? Column(
                                      children: List.generate(
                                        crimes['questions'][index]['list']
                                            .length,
                                        (j) => crimes['questions'][index]
                                                        ['list'][0]
                                                    .runtimeType
                                                    .toString() ==
                                                '_Map<String, dynamic>'
                                            ? Column(
                                                children: [
                                                  Text(
                                                    crimes['questions'][index]
                                                        ['list'][j]['start'],
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary,
                                                      decoration:
                                                          TextDecoration.none,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Column(
                                                    children: List.generate(
                                                      crimes['questions'][index]
                                                              ['list'][j]['go']
                                                          .length,
                                                      (k) => Text(
                                                        crimes['questions']
                                                                [index]['list']
                                                            [j]['go'][k],
                                                        style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: 16,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .arrow_circle_right_outlined,
                                                        size: 16,
                                                        color: Palette.blue,
                                                      ),
                                                      const SizedBox(width:2),
                                                      Expanded(
                                                        child: Text(
                                                          crimes['questions']
                                                              [index]['list'][j],
                                                          style: const TextStyle(
                                                            fontFamily: 'Nunito',
                                                            fontSize: 16,
                                                            color: Palette.purple,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(
            child: Text(
              'Loading...',
              style: TextStyle(
                fontSize: 40,
                color: Theme.of(context).primaryColor,
                fontFamily: 'Nunito',
                decoration: TextDecoration.none,
              ),
            ),
          );
        },
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });
  final String title, description, image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/careers/images/$image.png',
          width: 33,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 15),
        Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.none,
                fontFamily: 'Nunito',
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              description.toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                decoration: TextDecoration.none,
                fontFamily: 'Nunito',
                fontSize: 13,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        // const Spacer(),
      ],
    );
  }
}

class MyBullet extends StatelessWidget {
  const MyBullet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      width: 20.0,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
