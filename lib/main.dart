import 'package:flutter/material.dart';
import 'AddContacts.dart';
import 'EditContacts.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'contact',
      home: FirstPage1(),
    ),
  );
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FirstPage1();
  }
}

class FirstPage1 extends StatefulWidget {
  const FirstPage1({Key? key}) : super(key: key);

  @override
  State<FirstPage1> createState() => _FirstPage1State();
}

class _FirstPage1State extends State<FirstPage1> {
  List<dynamic> allMainContact = [];
  final savedContact = [];
  String contactName = '';
  int contactNumber = 0;
  List<dynamic> editedContact = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Contacts'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    displayContacts();
                    // varContact.clear();
                    print('list on add contact pressed $allMainContact');
                  },
                  child: const Text(
                    'Add Contacts +',
                    style: TextStyle(fontSize: 20),
                  )),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allMainContact.length,
                itemBuilder: (context, index) {
                  final item = allMainContact[index]['Name']; //doubt final
                  final item1 = allMainContact[index]['Mobile']; //doubt final
                  return
                    ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            onEditPressed(index);

                            print('Index onEditPressed $index');
                            print('contact name onEditPressed $item');
                            print('contact number onEditPressed $item1');
                          },
                          icon: const Icon(
                            Icons.mode_edit_sharp,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                        title: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          item1.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );

                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> displayContacts() async {
    final savedContact =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const AddContacts();
    }));
    setState(() {
      allMainContact = savedContact;
      print('list in setState of contact save $allMainContact');
    });
  }

  Future<void> onEditPressed(int index) async {
    final result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      print('index inside onEditPressed  method $index');
      return EditContacts(
        nameToEdit: allMainContact[index]['Name'],
        mobileToEdit: allMainContact[index]['Mobile'],
        ageToEdit: allMainContact[index]['Age'],
        contactList: allMainContact,
        // contactList: allMainContact[index],
      );
    }));
    setState(() {
      editedContact = result;
      allMainContact[index]['Name'] = editedContact[0];
      allMainContact[index]['Mobile'] = editedContact[1];
      print('result(edited contact) is printing inside setState $result');
      print('result\'s first element is printing inside setState ${result[0]}');
      // print(item1);
    });

    print('result is printing in on edit method $result');
  }
}
