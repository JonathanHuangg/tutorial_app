import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp()); // run myApp
}

// app itself is a widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider means that any widget in the app can get hold of the state
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App', 
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(), // starting point of the app
      ),
    );
  }
}

// ChangeNotifier manages app state
// MyAppState can notify other about its own changes
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners(); 
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) { // every widget has one to show stuff on screen
    var appState = context.watch<MyAppState>(); // track changes in the app

    return Scaffold( // build must always return a widget
      body: Column( // like in html
        children: [
          // There is hot reload here
          Text('Goat BAHHHHHHHHHH'),
          Text(appState.current.asLowerCase),

          // adding this is also hot reloaded
          ElevatedButton(onPressed: () {
            appState.getNext();
          }, 
          child: Text('Next'))
        ],
      ),
    );
  }
}