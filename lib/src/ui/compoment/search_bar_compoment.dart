import 'package:flutter/material.dart';

class SearchBarCompoemnt extends StatefulWidget {
  const SearchBarCompoemnt({Key? key}) : super(key: key);

  @override
  _SearchBarCompoemntState createState() => _SearchBarCompoemntState();
}

class _SearchBarCompoemntState extends State<SearchBarCompoemnt> {
  Widget appBarTitle = new Text('My Appbar Title');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
      ),
    );
  }
}
