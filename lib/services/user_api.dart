import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hey1/models/Users.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static Future<List<Users>> fetchUsers() async {
    List<Users> temp;

    print('Fuction started');
    const url = "https://randomuser.me/api/?results=50";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;

    temp = results.map((e) {
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
    ;

    print('fuction ran');
    return temp;
  }
}
