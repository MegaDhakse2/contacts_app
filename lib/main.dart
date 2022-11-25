import 'package:flutter/material.dart';
import 'AddContacts.dart';
void main() {
  runApp(const Contacts());
}

class Contacts extends StatelessWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'calculator',
      home: ContactsHome(),
    );
  }
}

class ContactsHome extends StatefulWidget {
  const ContactsHome({Key? key}) : super(key: key);

  @override
  State<ContactsHome> createState() => _ContactsHomeState();
}

class _ContactsHomeState extends State<ContactsHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Contacts'),
          ),
          body: Column(
              children: [
              TextButton(
              onPressed:()
          {
                Navigator.push(
             context,
          MaterialPageRoute(
             builder:
                (context) {
              return const AddContacts();
               }
             ),
           );
          // print(contactDetails.toString());
          },
          child: const Text('Add Contacts +'),
        ),
                // const Text(contatDetails)
     ],
    ),

    ),

    );
  }
}



