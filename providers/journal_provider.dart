import 'package:flutter/material.dart'; // For ChangeNotifier and other Flutter widgets
import 'package:isar/isar.dart';
import 'package:journal/models/journal.dart' as models; // Prefix for Journal class
import 'package:journal/models/journal_entry.dart'; // Importing the JournalEntry class

class JournalProvider extends ChangeNotifier {
  // A private journal field that will hold all journal entries
  final models.Journal _journal;

  // Constructor to initialize the provider with a Journal
  JournalProvider({Isar? isar})
      : _journal = models.Journal(isar: isar ?? Isar.getInstance()); // Default to a singleton instance if null

  // Getter to provide a clone of the journal
  models.Journal get journal => _journal.clone();

  // Method to add or update an entry in the journal
  void upsertJournalEntry(JournalEntry entry) {
    _journal.upsertEntry(entry); // Add or update the entry
    notifyListeners(); // Notify that the journal has changed
  }
}
