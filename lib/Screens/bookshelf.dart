import 'package:flutter/material.dart';

class MyBookshelf extends StatefulWidget {
  @override
  _MyBookshelfState createState() => _MyBookshelfState();
}

class _MyBookshelfState extends State<MyBookshelf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookshelf'),
      ),
      body: Center(
        child: Text('Welcome to My Bookshelf'),
      ),
    );
  }
}