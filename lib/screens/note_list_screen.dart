import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_hive_camera_shrdpref/models/note.dart';
import 'package:notes_hive_camera_shrdpref/screens/add_note_screen.dart';
import 'package:notes_hive_camera_shrdpref/screens/view_note.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('N O T E L Y'),
        centerTitle: false,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Note>('note').listenable(),
        builder: (context, Box<Note> box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (ctx, i) {
              final note = box.getAt(i);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ViewNoteScreen(
                            id: note!.id,
                            title: note.title,
                            description: note.description,
                            imageUrl: note.imageUrl,
                          ),
                        ),
                      );
                    },
                    leading: Image.file(
                      File(note!.imageUrl.toString()),
                    ),
                    title: Text(note.title.toString()),
                    subtitle: Text(note.id.toString()),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        await box.deleteAt(i);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const AddNoteScreen(),
            ),
          );
        },
        label: const Text('+ Add Note'),
      ),
    );
  }
}
