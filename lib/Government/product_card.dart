import "package:flutter/material.dart";

class Product_cart extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final Color backgroundcolor;
  final String link;

  const Product_cart({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.backgroundcolor, 
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(17),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: backgroundcolor, borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900])
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Center(
              child: Image(
                image: AssetImage(image),
                height: 175,
              ),
            )
          ]),
        ],
      ),
    );
  }
}
