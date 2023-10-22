import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_repository_using_provider/db/providers/student_provider.dart';
import 'package:student_repository_using_provider/screens/profile.dart';

class Search extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.pink, 
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final studenProvider = Provider.of<ProviderForStudent>(context);
    return Container(
      color: const Color.fromARGB(255, 228, 227, 213),
      padding: const EdgeInsets.only(top: 15),
      child: ListView.builder(
        itemBuilder: (context, index) {
          final data = studenProvider.students[index];
          if (data.name.toLowerCase().contains(query.toLowerCase().trim())) {
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                      return ProfileScreen(
                        index: index,
                      );
                    }));
                  },
                  leading: CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(
                      File(data.profile),
                    ),
                  ),
                  title: Text(data.name, style: const TextStyle(fontSize: 20)),
                ),
                const Divider(),
              ],
            );
          } else {
            return const Text('');
          }
        },
        itemCount: studenProvider.students.length,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final studentprovider = Provider.of<ProviderForStudent>(context);

    return Container(
      color: const Color.fromARGB(255, 228, 227, 213), 
      padding: const EdgeInsets.only(top: 15),
      child: ListView.builder(
        itemBuilder: (context, index) {
          final data = studentprovider.students[index];
          if (data.name.toLowerCase().contains(query.toLowerCase().trim())) {
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                      return ProfileScreen(
                        index: index,
                      );
                    }));
                  },
                  leading: CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(
                      File(data.profile),
                    ),
                  ),
                  title: Text(data.name, style: const TextStyle(fontSize: 20)),
                ),
                const Divider(),
              ],
            );
          }
          return null;
        },
        itemCount: studentprovider.students.length,
      ),
    );
  }
}
