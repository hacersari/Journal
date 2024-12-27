import 'package:journal/models/journal.dart';
import 'package:journal/models/journal_entry.dart';

// function to generate a mock Journal with fake data
Journal makeMockJournal() {
  final entries = [
    JournalEntry(
        text: 'I got tired today',
        id: 1,
        updatedAt: DateTime.now(), // Entry last updated now
        createdAt: DateTime.now()
            .subtract(const Duration(days: 2)), // Entry created 2 day ago
        feelingCategory: 'Sad',
        rateTheDay: 4),
    JournalEntry(
        text: 'lots of code today',
        id: 2,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now()
            .subtract(const Duration(days: 1)), // Entry created 1 day ago
        feelingCategory: 'Exhausted',
        rateTheDay: 1)
  ];

  return Journal(entries: entries); // return a journal with above entries
}
