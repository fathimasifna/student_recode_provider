import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../db/providers/student_provider.dart';
import 'edit.dart';

class ProfileScreen extends StatelessWidget {
  int index;
  ProfileScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderForStudent>(
      builder: (context, value, child) => Scaffold(
                backgroundColor: const Color.fromARGB(255, 228, 227, 213),

          appBar: AppBar(
            title: Text('Profile of ${value.students[index].name}'),
            centerTitle: true,
            backgroundColor: Colors.pink,
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                        width: 130,
                        child: Center(
                          child: Text(
                            'Details',
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.pink),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: FileImage(
                                      File(value.students[index].profile)),
                                  radius: 65,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 150,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            "Name",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            "Age",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text("Address",
                                              style: TextStyle(fontSize: 17)),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text("Phone Number",
                                              style: TextStyle(fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                    const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Text(
                                          ":",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Text(
                                          ":",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Text(":",
                                            style: TextStyle(fontSize: 17)),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Text(":",
                                            style: TextStyle(fontSize: 17)),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            value.students[index].name,
                                            style:
                                                const TextStyle(fontSize: 17),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            value.students[index].age,
                                            style:
                                                const TextStyle(fontSize: 17),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            value.students[index].address,
                                            style:
                                                const TextStyle(fontSize: 17),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Text(value.students[index].number,
                                              style: const TextStyle(
                                                  fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return EditStudent(index: index);
                            }));
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text("Edit Proile"))
                    ]),
              ),
            ),
          )),
    );
  }
}
