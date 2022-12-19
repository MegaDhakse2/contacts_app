import 'package:contacts_app/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class EditContacts extends StatefulWidget {
  final Map<String, dynamic> contactList;

  const EditContacts(
      {Key? key,
      required this.contactList,
        })
      : super(key: key);

  @override
  State<EditContacts> createState() => _EditContactsState();
}

class _EditContactsState extends State<EditContacts> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final ageController = TextEditingController();
  var pKey;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.contactList["name"].toString();
    mobileController.text = widget.contactList["mobile"].toString();
    ageController.text = widget.contactList["age"].toString();
    pKey = widget.contactList["id"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Edit Contact'),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(20, 40, 10, 20),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Name',
                ),
              ),
              TextFormField(
                controller: mobileController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter Mobile Number',
                ),
              ),
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter Age',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  onUpdateSavePressed(context);
                },
                child: const Text('Update and Save'),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void onUpdateSavePressed(BuildContext context) async {

    print('all database objects here(in edit page) before editing/updating ${await DbProvider().displayAllDBData()}');
    var editContact = ContactDetails(
        name: nameController.text,
        mobile: int.parse(mobileController.text),
        age: int.parse(ageController.text),
    );
   await updateData(editContact);
    print('all database objects here(in edit page) after editing/updating ${await DbProvider().displayAllDBData()}');
     Navigator.pop(context);
  }



  Future<void> updateData(ContactDetails data) async{
    print('printing index inside updateData $pKey');
    print('Modified data: $data');
    final db = await DbProvider().initializeDB();
    db.update('contactDetails',
      data.toMap(),
      where: 'id = ?',
      whereArgs: [pKey],
    );
    print('updataData is calling');
  }
}
