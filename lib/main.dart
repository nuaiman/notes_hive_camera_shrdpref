import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_hive_camera_shrdpref/screens/intro_screen.dart';
import 'package:notes_hive_camera_shrdpref/screens/note_list_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/note.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter<Note>(NoteAdapter());
  await Hive.openBox<Note>('note');

  runApp(const MyApp());
}

Future<bool> getVisitflag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool didVisit = preferences.getBool('didVisit') ?? false;
  return didVisit;
}

setVisitflag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool('didVisit', true);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: getVisitflag(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == true) {
            return const NoteListScreen();
          } else {
            return const IntroScreen();
          }
        },
      ),
    );
  }
}
