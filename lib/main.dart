import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Importing Google Fonts
import 'dart:math';
import 'package:http/http.dart' as http; // Importing http package
import 'dart:convert'; // Importing dart:convert for JSON decoding

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Quotes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.cabinTextTheme(), // Applying Google Fonts to the theme
      ),
      home: const MyAnimatedBackground(), // Use MyAnimatedBackground as the home
    );
  }
}

class MyAnimatedBackground extends StatefulWidget {
  const MyAnimatedBackground({Key? key}) : super(key: key);

  @override
  State<MyAnimatedBackground> createState() => _MyAnimatedBackgroundState();
}

class _MyAnimatedBackgroundState extends State<MyAnimatedBackground> with SingleTickerProviderStateMixin {
  // Definition of ParticleOptions
  ParticleOptions particles = const ParticleOptions(
    baseColor: Colors.cyan,
    spawnOpacity: 0.0,
    opacityChangeRate: 0.25,
    minOpacity: 0.1,
    maxOpacity: 0.4,
    particleCount: 70,
    spawnMaxRadius: 15.0,
    spawnMaxSpeed: 100.0,
    spawnMinSpeed: 30,
    spawnMinRadius: 7.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Random Quotes',
          style: TextStyle(
            fontSize: 32, // Increased font size for the heading
            fontWeight: FontWeight.bold, // Bold style for heading
            fontFamily: 'Poppins', // Changed font family for heading
            fontStyle: FontStyle.italic, // Italic style for heading
          ),
        ),
      ),
      body: AnimatedBackground(
        vsync: this,
        behaviour: RandomParticleBehaviour(options: particles),
        child: const MyHomePage(), // Using MyHomePage as child
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> quotes = []; // List to store fetched quotes
  String currentQuote = "Press the button to fetch a quote!"; // Default quote
  List<String> predefinedQuotes = [
    "You must be the change you wish to see in the world. – Mahatma Gandhi.",
    "Do one thing every day that scares you. – Eleanor Roosevelt.",
    "The best and most beautiful things in the world cannot be seen or even touched – they must be felt with the heart. – Helen Keller.",
    "Be yourself; everyone else is already taken. -Oscar Wilde.",
    "A journey of a thousand miles begins with a single step. – Lao Tzu.",
    "Eighty percent of success is showing up. – Woody Allen.",
    "It is during our darkest moments that we must focus to see the light. – Aristotle.",
    "Well done is better than well said. -Benjamin Franklin."
  ];

  void fetchQuote() async {
    final random = Random();
    setState(() {
      currentQuote = predefinedQuotes[random.nextInt(predefinedQuotes.length)]; // Select a random quote
      quotes.add(currentQuote); // Add the new quote to the list
    });

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            currentQuote,
            style: GoogleFonts.dancingScript( // Using a different font for the quote
              fontSize: 24, // Font size for the quote
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20), // Space between quote and button
          ElevatedButton(
            onPressed: fetchQuote,
            child: const Text('Fetch Quote'),
          ),
          const SizedBox(height: 20), // Space between button and previous quotes
          Text(
            'Previous Quotes:',
            style: GoogleFonts.cabin(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          for (var quote in quotes) // Display previous quotes
            Text(
              quote,
              style: GoogleFonts.cabin(fontSize: 16),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
