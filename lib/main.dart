import 'package:flutter/material.dart';
import './todoList.dart';
import './requests.dart';
import './exercises.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Gym - Todo app',
        home: new TodoList(),
    );
  }
}


