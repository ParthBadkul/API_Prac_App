import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];

  void fetchdata() async {
    const url = "https://randomuser.me/api/?results=100";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    users = json['results'];

    print(users);
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
            return ListTile(
              title: Text(users[index]['name']['first'].toString()),
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                      users[index]['picture']['thumbnail'].toString())),
              subtitle: Text(users[index]['email']),
            );
          },
        )),
        floatingActionButton: FloatingActionButton(onPressed: fetchdata),
      ),
    );
  }
}
