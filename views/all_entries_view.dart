import 'package:flutter/material.dart';
import 'package:journal/views/entry_view.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/journal_provider.dart';

class AllEntriesView extends StatelessWidget {
  const AllEntriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Journal Entries'), // Screen title
        actions: [
          IconButton(
            icon: const Icon(Icons.add), // Add button icon
            tooltip: 'Add new entry', // Accessibility hint for the button
            onPressed: () {
              // Create a new journal entry with default values
              final newEntry = JournalEntry.fromText(
                feelingCategory: 'Neutral', // Default feeling
                rateTheDay: 3, // Default rating
              );

              // Access the JournalProvider to add the new entry
              final journalProvider =
                  Provider.of<JournalProvider>(context, listen: false);
              journalProvider.upsertJournalEntry(newEntry); // Add the entry

              // Navigate to the detail view of the newly created entry
              _navigateToEntry(context, newEntry);
            },
          )
        ],
      ),
      body: Consumer<JournalProvider>(
        builder: (context, journalProvider, child) {
          final entries = journalProvider.journal.entries; // Get all journal entries
          return ListView.builder(
            itemCount: entries.length, // Number of entries
            itemBuilder: (context, index) {
              final entry = entries[index]; // Current entry
              return _createListElementForEntry(context, entry); // Display the entry
            },
          );
        },
      ),
    );
  }

  // Create a widget for each journal entry in the list
  Widget _createListElementForEntry(BuildContext context, JournalEntry entry) {
    return ListTile(
      title: Text(entry.text), // Show the journal's entry text
      subtitle: Text(
          _formatDateTime(entry.updatedAt)), // Show the last updated time
      onTap: () => _navigateToEntry(context, entry), // Open the entry on tap
    );
  }

  // Navigate to the EntryView for a specific journal entry
  Future<void> _navigateToEntry(
      BuildContext context, JournalEntry entry) async {
    final newEntry = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EntryView(entry: entry)), // Navigate to EntryView
    );

    if (!context.mounted) {
      return; // Exit if the context is no longer valid
    }

    // Update the journal with the modified entry
    final journalProvider =
        Provider.of<JournalProvider>(context, listen: false);
    journalProvider.upsertJournalEntry(newEntry);
  }

  // Format the date and time for display
  String _formatDateTime(DateTime when) {
    return DateFormat.yMd().add_jm().format(when); // Example: 11/25/2024 10:30 AM
  }
}
