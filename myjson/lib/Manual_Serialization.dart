import 'dart:convert';

// import 'package:flutter/material.dart';

void main() {
  User user = User('budi', 'budiee');
  var cek = user.toJson();

  var fromjson = User.fromJson(cek);
  print('tojson');
  print(cek);
  // print(fromjson);
  print('fromjson');
  print(user.name);
}

class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}

// String json = jsonEncode(user);

// Map<String, dynamic> userMap = jsonDecode(jsonString);
// var user = User.fromJson(userMap);