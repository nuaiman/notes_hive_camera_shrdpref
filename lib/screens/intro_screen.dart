import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:notes_hive_camera_shrdpref/screens/note_list_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final List<PageViewModel> _pages = [
    PageViewModel(
      title: "Hi, There!",
      body: "Welcome to this awsome app...",
      image: Center(
        child: Image.asset('assets/1.jpg', height: 175.0),
      ),
    ),
    PageViewModel(
      title: "N O T E L Y",
      body: '''
          I am your note taking buddy!
            Call me .....
        Notely 
          ''',
      image: Center(
        child: Image.asset('assets/2.jpg', height: 175.0),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          pages: _pages,
          onDone: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const NoteListScreen(),
              ),
            );
          },
          onSkip: () {
            // You can also override onSkip callback
          },
          showSkipButton: true,
          skip: const Icon(null),
          next: const Icon(null),
          done:
              const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
          dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              color: Colors.black26,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0))),
        ),
      ),
    );
  }
}
