import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_hive_camera_shrdpref/models/note.dart';
import 'package:image_picker/image_picker.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  XFile? _image;

  final _formKey = GlobalKey<FormState>();

  String? title;
  String? description;

  pickCamera() async {
    final image =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.getImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  pickGallery() async {
    final image =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.getImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void submit() async {
    final valid = _formKey.currentState!.validate();

    if (valid) {
      Hive.box<Note>('note').add(
        Note(
          id: DateTime.now().toString(),
          title: title,
          description: description,
          imageUrl: _image!.path,
        ),
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        actions: [
          IconButton(
            onPressed: pickGallery,
            icon: const Icon(Icons.image),
          ),
          IconButton(
            onPressed: pickCamera,
            icon: const Icon(Icons.camera_alt),
          ),
          IconButton(
            onPressed: submit,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  autocorrect: false,
                  onChanged: (val) {
                    setState(() {
                      title = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  autocorrect: false,
                  maxLines: 6,
                  onChanged: (val) {
                    setState(() {
                      description = val;
                    });
                  },
                ),
                _image == null
                    ? Container()
                    : Image.file(
                        File(_image!.path),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
