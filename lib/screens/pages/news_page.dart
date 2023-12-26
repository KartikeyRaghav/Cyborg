// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyborg/screens/pages/news_display_page.dart';
import 'package:http/http.dart' as http;
import 'package:cyborg/components/my_appBar.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Map data = {};
  List newsData = [];
  Map todayNewsData = {};

  getNews() async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsdata.io/api/1/news?apikey=pub_3504419f70c3f7a567068e0d1abade081cef8&q=cybercrime&language=en&category=crime,education,politics,science,technology'));
      data = json.decode(response.body);
      todayNewsData = data;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  addData() async {
    CollectionReference newsReference =
        FirebaseFirestore.instance.collection('news');
    await newsReference.doc('news').get().then((value) async {
      var fetchedNewsData = value.data() as Map<String, dynamic>;
      var today = DateTime.now().day.toString() +
          DateTime.now().month.toString() +
          DateTime.now().year.toString();
      var checker = fetchedNewsData['date'].toDate().day.toString() +
          fetchedNewsData['date'].toDate().month.toString() +
          fetchedNewsData['date'].toDate().year.toString();
      if (checker != today) {
        await getNews();
        for (var i in todayNewsData['results']) {
          fetchedNewsData['news']['results'].add(i);
        }
        newsReference.doc('news').update({
          'date': DateTime.now(),
          'news': {'results': fetchedNewsData['news']['results']}
        });
        newsData = fetchedNewsData['news']['results'];
      } else {
        newsData = fetchedNewsData['news']['results'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    addData();
    return Scaffold(
      body: FutureBuilder(
        future: addData(),
        builder: (context, snapshot) {
          return SafeArea(
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
                        iconData: Icons.document_scanner_outlined,
                        text: 'News',
                      ),
                      Column(
                        children: List.generate(
                          newsData.length,
                          (index) => Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NewsDisplayPage(
                                              news: newsData[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Center(
                                          child: Text(
                                            newsData[index]['title'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: const EdgeInsets.only(
                                        right: 20, left: 20),
                                    width: 40,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            // newsData[index]['image_url']
                                            'assets/logo.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
