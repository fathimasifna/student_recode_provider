import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_repository_using_provider/screens/addstudent.dart';
import 'package:student_repository_using_provider/screens/profile.dart';
import 'package:student_repository_using_provider/widgets/search.dart';
import '../db/providers/student_provider.dart';
import 'edit.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<ProviderForStudent>(context);
    studentProvider.getStudent();
    return Scaffold(
              backgroundColor: const Color.fromARGB(255, 228, 227, 213),

      appBar: AppBar(
        title: const Text(
          'Student Repository',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
            icon: const Icon(Icons.search),
          )
        ],
        backgroundColor: Colors.pink,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => AddStudent()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Consumer<ProviderForStudent>(
              builder: (context, value, child) => value.students.isNotEmpty
                  ? Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Flex(direction: Axis.vertical, children: [
                            ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return ProfileScreen(index: index);
                                }));
                              },
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                    File(value.students[index].profile)),
                              ),
                              title: Text(value.students[index].name),
                              subtitle: Text(value.students[index].age),
                              trailing: FittedBox(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return EditStudent(index: index);
                                        }));
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showAlert(context, index, value);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]);
                        },
                        separatorBuilder: (ctx, index) {
                          return const Divider();
                        },
                        itemCount: value.students.length,
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(
                          child: Text(
                        'No items to Display',
                        style: TextStyle(fontSize: 15),
                      )),
                    ))
        ],
      )),
    );
  }

  void showAlert(BuildContext context, int index, dynamic value) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'Do you want to delete ${value.students[index].name}',
            ),
            content: const Text(
                'All the related datas will be cleared from the database'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    value.deleteStudent(index);
                    Navigator.of(ctx).pop();
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }
}
