// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyborg/components/palette.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary_flutter/cloudinary_object.dart';
import 'package:cyborg/components/my_button.dart';
import 'package:cyborg/components/my_text_field.dart';
import 'package:cyborg/components/showBar.dart';
import 'package:cyborg/components/profile_widget.dart';
import 'package:cyborg/screens/Home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  File? image = File(
      'https://res.cloudinary.com/djyvtvxdh/image/upload/v1702898426/logo_zakijc.png');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  DateTime? date;
  String useruid = FirebaseAuth.instance.currentUser!.uid;
  var url;
  bool got = false;
  final cloudinary = CloudinaryObject.fromCloudName(cloudName: 'djyvtvxdh');

  String getText() {
    if (date == null) {
      return 'Date of Birth';
    } else {
      return '${date!.day}/${date!.month}/${date!.year}';
    }
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        if (image != null) {
          this.image = File(image.path);
        }
      });
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      showBar(e.message!, Icons.error_outline, context);
    }
  }

  Future uploadImage() async {
    try {
      final uri = Uri.parse('https://api.cloudinary.com/v1_1/djyvtvxdh/upload');
      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = 'images'
        ..files.add(await http.MultipartFile.fromPath('file', image!.path));
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        url = jsonMap['url'];
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      showBar(e.toString(), Icons.error_outline, context);
    }
  }

  Future pickDate(BuildContext context) async {
    final currentDate = DateTime.now();
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(currentDate.year - 100),
        lastDate: DateTime(currentDate.year + 1),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.dark(
                primary: Theme.of(context).colorScheme.inversePrimary,
                onPrimary: Theme.of(context).colorScheme.tertiary,
                onSurface: Palette.purple,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
            child: child!,
          );
        });
    if (pickedDate == null) return;

    setState(() {
      date = pickedDate;
    });
  }

  addData(BuildContext context) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
    try {
      await collectionReference.doc(useruid).set({
        'name': nameController.text,
        'image': url ?? image!.path,
        'dateOfBirth': date,
        'mobile': phoneController.text,
        'uid': useruid
      }).then(
        (value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        ),
      );
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      showBar(e.message!, Icons.error_outline, context);
    }
  }

  Future getData() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
    await collectionReference.doc(useruid).get().then(
          (DocumentSnapshot documentSnaphot) => {
            if (documentSnaphot.exists)
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                )
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    if (got == false) {
      getData().then((value) => {got = true});
    }

    return FutureBuilder<dynamic>(
      future: getData(),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.01),
                          spreadRadius: 10,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30.0,
                        right: 20,
                        left: 20,
                        bottom: 25,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Information',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Icon(
                                Icons.info_outline_rounded,
                                color: Theme.of(context).colorScheme.primary,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      children: [
                        ProfileWidget(
                          image: image!,
                          onPressed: () async {
                            pickImage(ImageSource.gallery);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: MyTextField(
                            controller: nameController,
                            hintText: 'Enter Name',
                            obscureText: false,
                            type: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(
                                width: 18,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => pickDate(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      padding: const EdgeInsets.all(0),
                                      shadowColor: Colors.transparent,
                                    ),
                                    child: Text(
                                      getText(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 110,
                                    child: Divider(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      thickness: 1,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: MyTextField(
                            controller: phoneController,
                            hintText: 'Mobile Number',
                            obscureText: false,
                            type: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: MyButton(
                            text: 'Submit',
                            onTap: () async {
                              if (nameController.text != '' &&
                                  phoneController.text != '' &&
                                  date != null) {
                                if (image!.path !=
                                    'https://res.cloudinary.com/djyvtvxdh/image/upload/v1702898426/logo_zakijc.png') {
                                  await uploadImage();
                                }
                                await addData(context);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .removeCurrentSnackBar();
                                showBar(
                                  'Please fill the fields',
                                  Icons.error_outline,
                                  context,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
