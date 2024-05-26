import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:groupchat/ChatBot/chat_bot.dart';
import 'package:groupchat/Food%20Donation/food_donation.dart';
import 'package:groupchat/Government/home_page.dart';
import 'package:groupchat/barter/donations.dart';
import 'package:groupchat/helper/helper_function.dart';
import 'package:groupchat/item%20donation/home_item_donation.dart';
import 'package:groupchat/library/app.dart';
import 'package:groupchat/pages/auth/login_page.dart';
import 'package:groupchat/pages/home_page.dart';
import 'package:groupchat/pages/profile_page.dart';
import 'package:groupchat/services/auth_service.dart';
import 'package:groupchat/services/data_base_service.dart';
import 'package:groupchat/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import '../../gadget donation/home_donate.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  @override

// fetching the user data from firebase
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  // string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
    // getting the list of snapshots in our stream
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 91),
          child: Text(
            "Saहाय्य",
            style: TextStyle(
                color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                _uploadProfilePicture();
              },
              child: Icon(
                Icons.account_circle,
                size: 150,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              userName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {
                nextScreenReplace(
                    context,
                    ProfilePage(
                      userName: userName,
                      email: email,
                    ));
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Logout"),
                        content: const Text("Are you sure you want to logout?"),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await authService.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false);
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    });
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.exit_to_app),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 1,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          children: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const Home()),
            //     );
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.only(top: 5),
            //     decoration: BoxDecoration(
            //         border: Border.all(color: Colors.black, width: 1.5),
            //         borderRadius: BorderRadius.circular(15)),
            //     height: 100,
            //     width: 100,
            //     child: Column(children: [
            //       Image.asset('assets/images/recieve.png',
            //           width: 120, height: 120),
            //       const Text(
            //         'Donate ',
            //         style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            //       )
            //     ]),
            //   ),
            // ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const HomeItem()),
            //     );
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.only(top: 5),
            //     decoration: BoxDecoration(
            //         border: Border.all(color: Colors.black, width: 1.5),
            //         borderRadius: BorderRadius.circular(15)),
            //     height: 100,
            //     width: 100,
            //     child: Column(children: [
            //       Image.asset('assets/images/recieve.png',
            //           width: 200, height: 120),
            //       const Text(
            //         'WishList ',
            //         style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            //       )
            //     ]),
            //   ),
            // ),
                        GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonationsPage()),
                );
              },
              child: Container(
               padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Color.fromARGB(255, 223, 222, 222))),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Image.asset('assets/images/recieve.png', width: 220, height: 220),
                    const Text(
                      'donations',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 35),
                    )
                  ]),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Color.fromARGB(255, 223, 222, 222))),
                child: Column(children: [
                  Image.asset('assets/community.jpg', width: 260, height: 220),
                  const Text(
                    'Community',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 35),
                  )
                ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
              child: Container(
               padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all
                            (
                                color: Color.fromARGB(255, 223, 222, 222))),
                child: Column(children: [
                  Image.asset('assets/library.jpg', width: 200, height: 220),
                  const Text(
                    'E-Library',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 35),
                  )
                ]),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => FoodDonation()),
            //     );
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.only(top: 5),
            //     decoration: BoxDecoration(
            //         border: Border.all(color: Colors.black, width: 1.5),
            //         borderRadius: BorderRadius.circular(15)),
            //     height: 100,
            //     width: 100,
            //     child: Column(children: [
            //       Image.asset('assets/food.jpg', width: 120, height: 120),
            //       const Text(
            //         'Food Donation',
            //         style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            //       )
            //     ]),
            //   ),
            // ),

            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => ChatBot()),
            //     );
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.only(top: 5),
            //     decoration: BoxDecoration(
            //         border: Border.all(color: Colors.black, width: 1.5),
            //         borderRadius: BorderRadius.circular(15)),
            //     height: 100,
            //     width: 100,
            //     child: Column(children: [
            //       Image.asset('assets/chatbot.jpg', width: 170, height: 120),
            //       const Text(
            //         'ChatBot',
            //         style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            //       )
            //     ]),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

Future<void> _uploadProfilePicture() async {
  AuthService authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  File? _image; // Make _image nullable
  final picker = ImagePicker();
  try {
    if (_image != null) {
      String userId = _auth.currentUser!.uid;
      Reference ref = _storage.ref().child('profile_pictures/$userId.jpg');
      await ref.putFile(_image!);
      String imageUrl = await ref.getDownloadURL();

      // TODO: Update the user's profile in Firebase with the imageUrl
      // For example, you can use Firestore to store user data including the profile picture URL.
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'profilePicture': imageUrl});

      // Display a success message or update UI accordingly.
      print('Profile picture uploaded successfully!');
    } else {
      // Handle case where no image is selected.
      print('No image selected');
    }
  } catch (e) {
    // Handle errors during the upload process.
    print('Error uploading profile picture: $e');
  }
}
