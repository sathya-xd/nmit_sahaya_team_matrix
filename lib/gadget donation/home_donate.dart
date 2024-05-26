import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groupchat/item%20donation/database.dart';
import 'package:groupchat/pages/select%20page/select_page.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
    String globalVariable = "";
class _HomeState extends State<Home> {
  Map<String, dynamic> employeeInfoMap = {
                        // "Name": namecontroller.text,
                        // "Age": agecontroller.text,
                        // "ID": Id,
                        // "Location": locationcontroller.text,
                        // "IamgeURL": imageUrl,
                        // "Phone": phonecontroller.text,
                        // "CurrentItems": currentontroller.text,
                        // "NeedItems": needcontroller.text
                      };
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  Stream<QuerySnapshot>? employeeStream;
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController currentontroller = TextEditingController();
  TextEditingController needcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    employeeStream = DataBaseMethods().getEmployeeDetailes();
  }

  void _runFilter(String enteredKeyword) {
    globalVariable=enteredKeyword;
    List<Map<String, dynamic>> employeeInfoMap = [];
    if (enteredKeyword.isEmpty) {
      setState(() {
        employeeStream = DataBaseMethods().getEmployeeDetailes();
      });
    }

    employeeInfoMap.forEach((employeeInfoMap) {
      if (employeeInfoMap["Name"].contains(enteredKeyword)) {
        setState(() {
          employeeStream = DataBaseMethods().getEmployeeDetailes();
        });
      }
      setState(() {
        employeeStream = DataBaseMethods().getEmployeeDetailes();
      
      });
    });
  }

  Widget allEmployeeDetailes() {
    return StreamBuilder(
        stream: employeeStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Container(
              child: Text("No data"),
            );
          }
          var filteredDocs = snapshot.data!.docs.where((doc) => doc['Name'].toString().contains(globalVariable)).toList();
          return ListView.builder(
            
              itemCount: filteredDocs.length,
  itemBuilder: (context, index) {
    DocumentSnapshot ds = filteredDocs[index];

                return Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                            color: Color.fromARGB(206, 226, 224, 224)),
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Material(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                      elevation: 5,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Color.fromARGB(255, 223, 222, 222))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius:
                                    70, // Increase this value to make the image larger
                                backgroundImage: NetworkImage(ds['IamgeURL']),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Name: " + ds["Name"],
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                  const Spacer(),
                                ]),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Age: " + ds["Age"],
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                String phoneNumber = ds["Phone"];
                                String url = "tel:$phoneNumber";
                                if (await canLaunch(
                                    Uri.parse(url).toString())) {
                                  await launchUrl(Uri.parse(url));
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Text(
                                "Phone " + ds["Phone"],
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Location: " + ds["Location"],
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Current items: " + ds["CurrentItems"],
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Need Items: " + ds["NeedItems"],
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 13,
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      await DataBaseMethods()
                                          .DeleteEmployeeDetailes(ds["ID"])
                                          .then((value) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // Close the dialog after 3 seconds
                                            Future.delayed(Duration(seconds: 3),
                                                () {
                                              Navigator.of(context).pop();
                                            });
                                            return AlertDialog(
                                              content: Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                                size:
                                                    100.0, // Adjust size as needed
                                              ),
                                            );
                                          },
                                        );
                                        Fluttertoast.showToast(
                                            msg: " Item Donated Successfully",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 40),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              maximumSize:
                                                  MaterialStateProperty.all(
                                                      Size(200, 100))),
                                          onPressed: null,
                                          child: Text(
                                            "Donate now",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                                fontSize: 18),
                                          )),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ));
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectPage()),
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                "GadgetDonation",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            Text(
              'Donate for Reuse',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Expanded(child: allEmployeeDetailes()),
          ],
        ),
      ),
    );
  }

  Future EditEmployeeDetailes(String id) => showDialog(
      context: context,
      builder: (content) => AlertDialog(
            content: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.cancel, color: Colors.red)),
                        SizedBox(
                          width: 60,
                        ),
                        const Text(
                          "Edit",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        const Text(
                          "Detailes",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Name",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: namecontroller,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Age",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: agecontroller,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Location",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: locationcontroller,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic> updateInfo = {
                            "Name": namecontroller.text,
                            "Age": agecontroller.text,
                            "ID": id,
                            "Location": locationcontroller.text
                          };
                          await DataBaseMethods()
                              .UpdateEmployeeDetailes(id, updateInfo)
                              .then((value) {
                            Navigator.pop(context);
                          });
                        },
                        child: Text("Update",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
}