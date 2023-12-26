import 'package:cyborg/components/my_appBar.dart';
import 'package:cyborg/components/my_button.dart';
import 'package:cyborg/components/my_text_field.dart';
import 'package:cyborg/components/showBar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController complain = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    iconData: Icons.description_rounded,
                    text: 'File Complaint',
                  ),
                  const SizedBox(height: 30),
                  MyTextField(
                    controller: complain,
                    hintText: 'Complaint',
                    obscureText: false,
                    type: TextInputType.multiline,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: website,
                    hintText: 'Website where the fraud happend(Optional)',
                    obscureText: false,
                    type: TextInputType.multiline,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: address,
                    hintText: 'Address',
                    obscureText: false,
                    type: TextInputType.multiline,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: date,
                    hintText: 'Date',
                    obscureText: false,
                    type: TextInputType.datetime,
                  ),
                  const SizedBox(height: 20),
                  MyButton(
                    text: 'Submit',
                    onTap: () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      showBar('Feature under development', Icons.info, context);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
