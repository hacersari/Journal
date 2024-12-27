import 'package:flutter/material.dart';
import 'package:journal/providers/journal_provider.dart';
import 'package:journal/views/all_entries_view.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'models/journal_entry.dart';

Future<void> main() async {
  // Ensures that Flutter bindings are initialized before accessing platform channels or services.
  WidgetsFlutterBinding.ensureInitialized();

  // Get the directory for storing Isar database files
  final dir = await getApplicationDocumentsDirectory();

  // Open the Isar database with the schema defined in 'JournalEntry'
  final isar = await Isar.open([JournalEntrySchema], directory: dir.path);

  // Start the app and provide the JournalProvider to the widget tree
  runApp(
    ChangeNotifierProvider(
      create: (context) => JournalProvider(isar: isar), // Explicitly pass the Isar instance
      child: const MyApp(), // The root widget of the app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal App', // Application title for screen readers and accessibility tools
      debugShowCheckedModeBanner: false, // Hides the debug banner in the app
      theme: ThemeData(
        // Defines the color scheme and material design theme for the app
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown), // Seed-based color scheme
        useMaterial3: true, // Opt-in for Material Design 3
      ),
      home: const AllEntriesView(), // The initial screen of the app
    );
  }
}
