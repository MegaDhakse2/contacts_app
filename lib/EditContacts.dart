import 'package:flutter/material.dart';

// import 'main.dart';
class EditContacts extends StatefulWidget {
  final String nameToEdit;
  final mobileToEdit;
  final int ageToEdit;
  final List<dynamic> contactList;

  const EditContacts(
      {Key? key,
      required this.nameToEdit,
      required this.mobileToEdit,
      required this.ageToEdit,
      required this.contactList})
      : super(key: key);

  @override
  State<EditContacts> createState() => _EditContactsState();
}

class _EditContactsState extends State<EditContacts> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.nameToEdit;
    mobileController.text = '${widget.mobileToEdit}';
    ageController.text = '${widget.ageToEdit}';
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
              // TextButton(onPressed: () {
              //   setState(() {
              //     widget.contactList.clear();
              //   });
              // },
              //     child: const Text('delete'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void onUpdateSavePressed(BuildContext context) {
    List<dynamic> dummy = [nameController.text, mobileController.text];
    // Navigator.pop(context, dummy);
    Navigator.of(context).pop(dummy);
  }
}
