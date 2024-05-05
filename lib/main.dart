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

  var favorites = <WordPair>[];

  // add/remove to/from favorites list
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) { // every widget has one to show stuff on screen
    var appState = context.watch<MyAppState>(); // track changes in the app
    var pair = appState.current; // extract appState.current into its own widget so you can do more stuff to it

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Scaffold( // build must always return a widget
      body: Center(
        child: Column( // like in html
          mainAxisAlignment: MainAxisAlignment.center, // this centers the children with each other
          children: [
            // There is hot reload here
            Text('Goat BAHHHHHHHHHH'),
            BigCard(pair: pair), // this used to be Text(pair.aslowercase) but after extracting as its own widget
        
            // adding this is also hot reloaded
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(onPressed: () {
                  appState.getNext();
                }, 
                child: Text('Next')),

                ElevatedButton.icon(onPressed: () {
                  appState.toggleFavorite();
                }, 
                icon: Icon(icon),
                label: Text('Favorite'),),
                SizedBox(width: 10),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// This was automatically created
class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // requests current app theme
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    
    return Card (
      color: theme.colorScheme.primary, // uses primary color of the app
      child: Padding( // Refactored to wrap padding, then refactored to wrap widget
        padding: const EdgeInsets.all(8.0),
        child: Text( // this reminds me of html
          pair.asLowerCase, 
          style: style,
          semanticsLabel: "${pair.first}, ${pair.second}",
        ), 
      ),
    );
  }
}