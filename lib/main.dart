import 'dart:async';
import 'package:contacts_app/provider/db_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_contacts.dart';
import 'edit_contacts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(home: FirstPage(),));
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
  List<dynamic> savedContact = [];
  int mobile = 0;
  List<dynamic> editedContact = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    print('savedContact is $savedContact');
  }

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
                    addContacts();
                    print('list on add contact pressed(savedContact) $savedContact');

                  },
                  child: const Text(
                    'Add Contacts +',
                    style: TextStyle(fontSize: 20),
                  )),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: savedContact.length,
                itemBuilder: (context, index) {
                  final item = savedContact[index]['name']; //doubt final
                  final item1 = savedContact[index]['mobile']; //doubt final
                  return
                    ListTile(
                        trailing:   IconButton(onPressed: () {
                          onDeletePressed(index);
                        },
                          icon: const Icon(Icons.delete, color: CupertinoColors.darkBackgroundGray, size: 30,
                          ),
                        ),

                        title: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              item1.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                onEditPressed(index);
                                print('Index onEditPressed $index');
                                print('contact name onEditPressed $item');
                                print('contact number onEditPressed $item1');
                              },
                              icon: const Icon(
                                Icons.mode_edit_sharp,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                },
              )
            ],
          ),

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            fetchData();
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }

  Future<void> addContacts()  async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const AddContacts();
    })).then((_) {
      setState(() {
        fetchData();
      });
    });
    // print('savedContact after initialization is $savedContact');

  }


  Future<void> onEditPressed(int index) async {
       print('oneditpressed is calling');
       print('index $index');
       print(' name before edit ${savedContact[index]['name']}');
    final result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      print('index inside onEditPressed  method $index');
      return EditContacts(
        contactList: savedContact[index],
      );
    })).then((_) {
      setState(() {
        fetchData();
      });
        });

    setState(() {
      editedContact = result;
      savedContact[index]['name'] = editedContact[0];
      savedContact[index]['mobile'] = editedContact[1];
      print('result(edited contact) is printing inside setState $result');
      print('result\'s first element is printing inside setState ${result[0]}');
      // print(item1);
    });
    print('result is printing in on edit method $result');
  }

  void fetchData() async{
    final db = await DbProvider().initializeDB();
    savedContact = await db.query('contactDetails');
    print(savedContact.length);
    print('this is db(savedContact) $savedContact');
    setState(() { });
  }

  void onDeletePressed(int index) async {
    final db = await DbProvider().initializeDB();
    mobile = savedContact[index]['mobile'];
    db.delete('contactDetails',
    where: 'mobile = ?',
      whereArgs: [mobile],
    );
    fetchData();
  }
}

