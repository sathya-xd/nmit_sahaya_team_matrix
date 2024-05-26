import 'package:flutter/material.dart';
import 'package:groupchat/Food%20Donation/food_donation.dart';
import 'package:groupchat/gadget%20donation/home_donate.dart';
import 'package:groupchat/item%20donation/home_item_donation.dart';
import 'package:groupchat/library/app.dart';
import 'package:groupchat/pages/home_page.dart';

class DonationsPage extends StatelessWidget {
  final List<String> items = ['Item 1', 'Item 2', 'Item 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donations Page'),
      ),
      body: Container(

        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 1,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
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
                  Image.asset('assets/images/recieve.png',
                      width: 220, height: 220),
                  Text(
                    'Donate ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 35),
                  )
                ]),
              ),
            ),
            GestureDetector(
              onTap: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeItem()),
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
                  Image.asset('assets/images/recieve.png',
                      width: 200, height: 220),
                  const Text(
                    'WishList ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 35),
                  )
                ]),
              ),
            ),
            
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FoodDonation()),
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
                  Image.asset('assets/food.jpg', width: 220, height: 220),
                  const Text(
                    'Food Donation',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 35),
                  )
                ]),
              ),
            ),


          ],
        ),
      ),
    );
  }
}