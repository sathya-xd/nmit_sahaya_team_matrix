// ignore_for_file: unused_import

import "dart:math";
import "dart:ui";

import "package:flutter/material.dart";
import "package:provider/provider.dart";

import 'package:url_launcher/url_launcher.dart';

class Product_detailes_page extends StatefulWidget {
  final Map<String, Object> product;

  const Product_detailes_page({super.key, required this.product});

  @override
  State<Product_detailes_page> createState() => _Product_detailes_pageState();
}

class _Product_detailes_pageState extends State<Product_detailes_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Detailes',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: Column(
          children: [
            Text(
              widget.product['title'] as String,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  widget.product['imageurl'] as String,
                  height: 250,
                )),
            const Spacer(
              flex: 2,
            ),
            Container(
              height: 240,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(245, 247, 249, 1),
                borderRadius: BorderRadius.circular(40),
                // boxShadow: const [BoxShadow(blurRadius: 8)]
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.product['description']}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final link = widget.product['link'] as String;
                          launchUrl(Uri.parse(link),
                              mode: LaunchMode.externalApplication);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            fixedSize: const Size(350, 50)),
                        icon: const Icon(
                          Icons.link,
                          color: Colors.black,
                        ),
                        label: Text(
                          'Go To: ${widget.product['title']}',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ]),
            )
          ],
        ));
  }
}
