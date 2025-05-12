import 'package:flutter/material.dart';
import 'package:memenote/pages/home_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meme Note",
      theme: ThemeData( scaffoldBackgroundColor: Colors.grey[700]),
      home: HomePage(),
    );
  }
}