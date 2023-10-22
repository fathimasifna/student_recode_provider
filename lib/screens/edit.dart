import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../db/model/student_model.dart';
import '../db/providers/image_provide.dart';
import '../db/providers/student_provider.dart';

class EditStudent extends StatefulWidget {
  int index;
  EditStudent({super.key, required this.index});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController namegcontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    final studentProvider =
        Provider.of<ProviderForStudent>(context, listen: false);
    String name = studentProvider.students[widget.index].name;
    namegcontroller = TextEditingController(text: name);

    String age = studentProvider.students[widget.index].age;
    agecontroller = TextEditingController(text: age);

    String address = studentProvider.students[widget.index].address;
    addresscontroller = TextEditingController(text: address);

    String number = studentProvider.students[widget.index].number;
    numbercontroller = TextEditingController(text: number);

    String profile = studentProvider.students[widget.index].profile;

    final tempImageProvider =
        Provider.of<TempImageProvider>(context, listen: false);
    tempImageProvider.tempImagePath = profile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 228, 227, 213),
        appBar: AppBar(
          title: Text('Edit Profile of ${numbercontroller.text}'),
          backgroundColor: Colors.pink,
        ),
        body: SafeArea(
          
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Consumer<TempImageProvider>(
                  builder: (context, value2, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: value2.tempImagePath == null
                            ? const CircleAvatar(
                                backgroundImage: AssetImage('assets/man.jpg'),
                                radius: 65,
                              )
                            : CircleAvatar(
                                radius: 65,
                                backgroundImage: FileImage(
                                  File(value2.tempImagePath!),
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          getimage(value2);
                        },
                        icon: const Icon(Icons.photo),
                        label: const Text('Add your Photo'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: numbercontroller,
                        keyboardType: TextInputType.name,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            prefixIcon: Icon(Icons.person)),
                        validator: (value) {
                          if (numbercontroller.text.isEmpty) {
                            return 'Enter your Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: agecontroller,
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            labelText: 'Age',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            prefixIcon: Icon(Icons.calendar_month)),
                        validator: (value) {
                          if (agecontroller.text.isEmpty) {
                            return 'Enter your Age';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: addresscontroller,
                        keyboardType: TextInputType.streetAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            labelText: 'Address',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            prefixIcon: Icon(Icons.home)),
                        validator: (value) {
                          if (addresscontroller.text.isEmpty) {
                            return 'Enter your Address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: numbercontroller,
                        keyboardType: TextInputType.phone,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            labelText: 'Number',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            prefixIcon: Icon(Icons.phone)),
                        maxLength: 10,
                        validator: (value) {
                          if (numbercontroller.text.isEmpty) {
                            return 'Enter your Phone Number';
                          } else if (numbercontroller.text.length < 10) {
                            return 'Enter a valid Phone Number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(120, 38),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.grey,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.cancel),
                            label: const Text('Cancel'),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(120, 38),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.pink,
                            ),
                            onPressed: () {
                              final tempImageProvider =
                                  Provider.of<TempImageProvider>(context,
                                      listen: false);
                              if (formkey.currentState!.validate()) {
                                if (tempImageProvider.tempImagePath == null) {
                                  addingFailed();
                                } else {
                                  updateSuccess(widget.index);
                                }
                              }
                            },
                            icon: const Icon(Icons.send),
                            label: const Text("Submit"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getimage(TempImageProvider value) async {
    await value.getImage();
  }

  void addingFailed() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Please add photo !'),
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 3),
    ));
  }

  void updateSuccess(int id) {
    final value = Provider.of<ProviderForStudent>(context, listen: false);
    final value2 = Provider.of<TempImageProvider>(context, listen: false);
    StudentModel st = StudentModel(
      profile: value2.tempImagePath!,
      name: numbercontroller.text.trim(),
      age: agecontroller.text.trim(),
      address: addresscontroller.text.trim(),
      number: numbercontroller.text.trim(),
    );
    value.editStudent(id, st);
    value2.tempImagePath = null;
    value2.notify();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${numbercontroller.text}'s details updated successfully"),
      backgroundColor: Colors.pink,
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(seconds: 2),
    ));
    value2.tempImagePath = null;
    Navigator.of(context).pop();
  }
}
