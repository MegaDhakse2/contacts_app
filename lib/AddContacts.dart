import 'package:flutter/material.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({Key? key}) : super(key: key);

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  static final nameController = TextEditingController();
  static final mobileNumController = TextEditingController();
  static final ageController = TextEditingController();

  static List<dynamic> onSavingContactDetails = [];
  var mapdata = {};

  onSavePressed(BuildContext context) {
    String name = nameController.text;
    int mobile = int.parse(mobileNumController.text);
    int age = int.parse(ageController.text);

    mapdata['Name'] = name;
    mapdata['Mobile'] = mobile;
    mapdata['Age'] = age;

    print('data in map $mapdata');
    print('list on save ${onSavingContactDetails.join('   ')}');
    print('list before adding mapdata $onSavingContactDetails');
    onSavingContactDetails.add(mapdata);
    print('list after adding mapdata $onSavingContactDetails');

    nameController.text = '';
    mobileNumController.text = '';
    ageController.text = '';

    Navigator.pop(context, onSavingContactDetails);
  }

  // onSavePressed(BuildContext context){
  //   String name = nameController.text;
  //   Navigator.pop(context, name);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Add Contacts'),
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
                controller: mobileNumController,
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
                  onSavePressed(context);
                },
                child: const Text('Save Contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
