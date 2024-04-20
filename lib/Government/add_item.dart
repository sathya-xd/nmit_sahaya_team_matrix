import 'package:flutter/material.dart';
import 'package:groupchat/Government/global_variables.dart';

class AddItem extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String id = '';
  String item = '';
  String donor = '';
  String imageUrl = '';
  String mapUrl = '';
  List<String> size = [];
  bool isAvailable = true;

  AddItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Items'),
        backgroundColor: Colors.teal,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Item'),
              onSaved: (value) => item = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Donor'),
              onSaved: (value) => donor = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Image URL'),
              onSaved: (value) => imageUrl = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Map URL'),
              onSaved: (value) => mapUrl = value!,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  id = product.length.toString(); // Set id to the length of products list
                  // TODO: Add these values to Global_variable.dart page
                }
              },
              child: const Text('Donate Now'),
            ),
          ],
        ),
      ),
    );
  }
}