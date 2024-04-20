import "package:flutter/material.dart";
import "package:groupchat/Government/global_variables.dart";
import "package:groupchat/Government/product_card.dart";
import "package:groupchat/Government/product_detailes_page.dart";
import "package:groupchat/pages/select%20page/select_page.dart";



class product_list extends StatefulWidget {
  const product_list({super.key});

  @override
  State<product_list> createState() => _product_listState();
}

class _product_listState extends State<product_list> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
  backgroundColor: Colors.blue, // Set AppBar background color to blue
  title: Text('Government Schemes',style: TextStyle(fontSize: 30),), // Set AppBar title to 'Government Schemes'
  leading: BackButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SelectPage()),
      );
    },
  ),
),
  body: SafeArea(
    //helps to make items below the notch and above the bottom-safe area
    child: Column(
      children: [
        const Row(
          children: [
            // Padding(
            //   padding: EdgeInsets.all(10),
            //   child: Text('Governerment Schemes',
            //       style:
            //           TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            // ),
          ],
        ),
        Expanded(
          child: ListView.builder(
              itemCount: product.length,
              itemBuilder: (context, index) {
                final products = product[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Product_detailes_page(product: products);
                    }));
                  },
                  child: Product_cart(
                    title: products['title'] as String,
                    description:  products['description'] as String,
                    image: products['imageurl'] as String,
                    link :products['link'] as String,
                    backgroundcolor: index.isEven
                        ? const Color.fromRGBO(216, 240, 253, 1)
                        : const Color.fromARGB(255, 243, 244, 244),
                 ),
                );
              }),
        )
      ],
    ),
  ),
);
  }
}
