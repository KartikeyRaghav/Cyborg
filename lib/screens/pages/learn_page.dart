import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyborg/components/my_appBar.dart';
import 'package:cyborg/screens/pages/crime_page.dart';
import 'package:flutter/material.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  List crimeList = [];
  List crime = [];
  CollectionReference crimeReference =
      FirebaseFirestore.instance.collection('crimes');

  getCrimes() async {
    crimeList = [];
    crime = [];

    await crimeReference.get().then((value) {
      for (var element in value.docs) {
        var data = element.data() as Map<String, dynamic>;
        if (crime.contains(data['title'])) {
        } else {
          crimeList.add(data);
          crime.add(data['title']);
        }
      }
    });
  }

  addData() async {
    CollectionReference crimeReference =
        FirebaseFirestore.instance.collection('crimes');
    await crimeReference.doc('Cyber Stalking').set({
      'title': 'Cyber Stalking',
      'questions': [
        {
          'answer': [
            "Cyberstalking is a crime committed when someone uses the internet and other technologies to harass or stalk another person online. Even though cyberstalking is a broad term for online harassment, it can include defamation, false accusations, teasing, and even extreme threats. Often these connections will not end even though the receiver requests the person to stop. The content addressed at the target is frequently improper and, at times, disturbing, leaving the individual beginning to feel fear.",
          ],
          'question': 'What is Cyberstalking?',
        },
        {
          'answer': [
            "The three most common types of cyber stalking are as follows:",
          ],
          'question': 'Types of Cyberstalking',
          'list': [
            {
              'start': 'Email stalking',
              'go': [
                'This type of stalking involves the sender sending hateful, obscene, or threatening emails to the recipient. Sometimes the attacker may also include viruses and spam in the email.',
              ],
            },
            {
              'start': 'Internet stalking',
              'go': [
                'This type of stalking occurs when an individual spreads rumors or tracks victims on the internet. The goal of spreading rumors is to slander the victim.',
              ],
            },
            {
              'start': 'Computer stalking',
              'go': [
                'This type of stalking occurs when an individual hacks into a victim’s computer and takes control of it. This requires advanced computer skills; however, one can find guidelines on the web.'
              ],
            },
          ]
        },
        {
          'answer': [
            "Some of the common examples of cyberstalking are:",
          ],
          'question': 'Examples of Cyberstalking',
          'list': [
            'Making rude, offensive, or suggestive online comments',
            'Joining the same groups and forums to follow the target online',
            'Sending the target threatening, controlling, or lewd messages or emails',
            'Making a fake social media profile to follow the victim',
            'Gaining access to the victim’s online accounts',
            'Posting or disseminating real or fictitious photos of the victim',
            'Attempting to obtain explicit photographs of the victim',
            'Tracking the victim’s online movements using tracking devices',
            'Mailing explicit photos of themselves to the victim on a regular basis, etc.',
          ],
        },
        {
          'answer': [],
          'question': 'Some real-life cases related to cyberstalking in India',
          'list': [
            'Khanna received a string of e-mails from a man who asked her to pose naked for him or pay him Rs 1 lakh in a clear case of cyber stalking. The woman stated that she began receiving these emails in the third week of November 2003. The accused threatened Khanna by posting her morphed images on sex websites alongside her contact details. She initially ignored the emails, but she soon began receiving letters in the mail that repeated the same threat. She felt compelled to notify the cybercrime unit of the incident.',
            'The Rajkot cyber crime police arrested two men in separate cases on February 3, 2022, for alleged cyberstalking of teenage girls by morphing their pictures on social media.',
          ],
        },
        {
          'answer': [
            "Cyberstalking is similar to stalking in that it has negative consequences for victims, both physically and mentally. Cyberstalking can have a wide variety of physical and emotional consequences for all who are attacked. Victims report various severe consequences of victimization, including increased suicidal ideation, fear, anger, depression, and PTSD symptomatology.",
          ],
          'question': 'Consequences of Cyberstalking',
        },
        {
          'question': 'How to prevent Cyberstalking?',
          'answer': [
            'To prevent yourself from being the victim of cyberstalking, you should follow these habits:'
          ],
          'list': [
            {
              'start': 'Hide your IP address',
              'go': [
                'Numerous apps and services display your IP address to the person you are interacting with. It might seem not very meaningful, but it is directly related to your personal information. Your IP address, for example, is linked to your internet bill, delivered to your home, and you pay for that using a credit card. Cyberstalkers can use your IP address to find your credit card information and physical address.',
              ]
            },
            {
              'start': 'Adjust privacy settings',
              'go': [
                'One of the first steps you can take to adjust your privacy settings. Most social media networks and other online accounts allow you to control who can see and contact you.',
              ],
            },
            {
              'start': 'Avoid disclosing sensitive information',
              'go': [
                'Unexpectedly, many people share personal information about themselves when filling out questionnaires or applying for coupons. This increases the possibility of someone obtaining your personal information and possibly making cyberstalking more accessible.',
              ],
            },
            {
              'start': 'Update your software',
              'go': [
                'When it comes to preventing information leaks, regular software updates are critical. Developers keep on updating and creating new updates to address security flaws and ensure the safety of your data.',
              ],
            },
            {
              'start': 'Maintain a low profile',
              'go': [
                'It can be difficult for some people to maintain a low profile online. But you should always refrain from posting personal information such as your phone number and address, and think twice before disclosing real-time information about where you are and who you’re with.',
              ],
            },
          ],
        },
        {
          'question': 'How to deal with Cyberstalking?',
          'answer': [
            'Send a clear written message to the cyberstalker indicating that you do not want to be contacted by them. Do not interact with the stalker after receiving a warning. If the harassment continues, contact the police. Call a family member or friend for assistance if you believe you are being tracked by spyware.',
            'Check your devices for spyware or indications of compromised accounts, and change all passwords. Block the person from your social media accounts using privacy settings, and report the abuse to the network. Even if the attacker does not back down, call the police.',
          ]
        },
        {
          'question': 'Difference between Cyberstalking and Cyberbullying',
          'answer': [],
          'list': [
            {
              'start': 'Cyberstalking',
              'go': [
                'Cyberstalking occurs when a victim is harassed online via electronic channels, text messaging, social networking sites, discussion forums, and so on for retaliation, anger, or control. A stalker could be a stranger or a friend of the victim. When adults are involved, it is referred to as cyberstalking.',
              ],
            },
            {
              'start': 'Cyberbullying',
              'go': [
                'Cyberbullying occurs when a child or a teenager is mistreated, disrespected, tormented, intimidated, humiliated, or aimed at by another individual of the same age range via the internet.'
              ],
            },
          ],
        },
        {
          'question': 'Laws in India against Cyberstalking',
          'answer': [
            'The following laws are available in India to deal with cyberstalking:',
          ],
          'list': [
            {
              'start': 'Section 67 of the Information Technology Act of 2000',
              'go': [
                'Penalises stalkers who send or cause to be sent or published obscene posts or content on electronic media with up to three years in prison and a fine.',
              ]
            },
            {
              'start': 'Section 67A of the Information Technology Act of 2000',
              'go': [
                'Penalises anyone who sends or causes to be sent or published in electronic media any material containing sexually explicit acts or conduct. Up to five years in prison and a fine of up to five lakh rupees are the penalties.'
              ]
            },
            {
              'start': 'Section 354D of the Indian Penal Code, 1860',
              'go': [
                'Under this section, if a person monitors a woman’s use of the internet, email, or any other form of electronic communication, that person may face up to 3 years in prison as well as a fine. This is a bailable offense for first-time offenders but not for repeat offenders.',
                'If a woman is a victim of cyberstalking, she can file a complaint with any cybercrime unit, regardless of where the incident occurred. Cyber cells are being established to address the grievances of female victims.'
              ]
            },
          ]
        }
      ],
    });
  }

  @override
  Widget build(BuildContext context) {
    // addData();
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getCrimes(),
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
                        iconData: Icons.menu_book_rounded,
                        text: 'Learn',
                      ),
                      const SizedBox(height: 30),
                      Column(
                        children: List.generate(
                          crimeList.length,
                          (index) => Column(
                            children: [
                              Container(
                                height: 180,
                                margin:
                                    const EdgeInsets.only(right: 20, left: 20),
                                width: size.width > 700
                                    ? size.width * 0.4
                                    : size.width * 0.8,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      crimeList[index]['image'],
                                    ),
                                    fit: BoxFit.cover,
                                    opacity: 0.3,
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CrimePage(
                                          list: crimeList,
                                          title: crimeList[index]['title'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                      child: Text(
                                        crimeList[index]['title'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
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
    );
  }
}
