import 'dart:io';

import 'package:flutter/material.dart';

class ViewNoteScreen extends StatefulWidget {
  final String? id;
  final String? title;
  final String? imageUrl;
  final String? description;

  const ViewNoteScreen({
    Key? key,
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  _ViewNoteScreenState createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Note'),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Text(
            widget.title.toString(),
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.description.toString(),
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Image.file(
            File(widget.imageUrl.toString()),
          ),
        ],
      )),
    );
  }
}
