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



  static List<dynamic> contactDetails = [];


  onSavePressed()
  {
    String name = nameController.text;
    int mobile = int.parse(mobileNumController.text);
    int age = int.parse(ageController.text);

    contactDetails.insert(0,name);
    contactDetails.insert(1,mobile);
    contactDetails.insert(2,age);

    print(contactDetails.join('   '));

    nameController.text = '';
    mobileNumController.text = '';
    ageController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  hintText:'Enter Name',
                ),
              ),TextFormField(
                controller: mobileNumController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText:'Enter Mobile Number',
                ),
              ),TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText:'Enter Age',
                ),
              ),

              const SizedBox( height: 30,),
              ElevatedButton(
                onPressed: ()
                {
                  onSavePressed();
                },
                child: const Text('Save Contact'),
              ),
              // Container(child: Text(contactDetails.join('   ')),

            ],
          ),
        ),
      ),
    );
  }
}
