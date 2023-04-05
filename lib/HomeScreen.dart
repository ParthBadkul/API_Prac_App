import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hey1/models/Users.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Users> users = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }

  void fetchdata() async {
    print('Fuction started');
    const url = "https://randomuser.me/api/?results=50";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    setState(() {
      users = results.map((e) {
        final name = UserName(
            first: e['name']['first'],
            last: e['name']['last'],
            title: e['name']['title']);
        final pic = Picture(thumbnail: e['picture']['thumbnail']);

        return Users(
          email: e['email'],
          gender: e['gender'],
          phone: e['phone'],
          name: name,
          pic: pic,
        );
      }).toList();
    });

    print('fuction ran');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple[300],
        body: Center(
            child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            // final user = users[index];

            return ListTile(
              title: Text(users[index].name.first),
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(users[index].pic.thumbnail.toString())),
              subtitle: Text(users[index].email),
              // tileColor:
              // users[index].gender == 'male' ? Colors.amber : Colors.black12,
            );
          },
        )),
        floatingActionButton: FloatingActionButton(onPressed: fetchdata),
      ),
    );
  }
}
