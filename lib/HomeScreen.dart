import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hey1/models/Users.dart';
import 'package:http/http.dart' as http;
import 'package:hey1/services/user_api.dart';

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
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await UserApi.fetchUsers();
    setState(() {
      users = response;
    });
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
              title: Text(users[index].fullName),
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(users[index].pic.thumbnail.toString())),
              subtitle: Text(users[index].email),
              // tileColor:
              // users[index].gender == 'male' ? Colors.amber : Colors.black12,
            );
          },
        )),
        floatingActionButton: FloatingActionButton(onPressed: fetchData),
      ),
    );
  }
}
