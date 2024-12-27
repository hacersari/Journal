// Journal class manages all changes to the journal and its entries, ensuring organization.
import 'package:journal/models/journal_entry.dart';
import 'package:isar/isar.dart';

class Journal {
  // List of journal entries
  final List<JournalEntry> _entries;

  // Isar instance for database interaction (nullable for flexibility)
  final Isar? _isar;

  // Optional name field for the journal
  final String name;

  // Constructor to initialize a new journal
  Journal({
    this.name = "Aynur's Feelings", // Default name for the journal
    Isar? isar, // Optional Isar database instance
  })  : _isar = isar,
        _entries = isar?.collection<JournalEntry>().where().findAllSync() ?? []; // Initialize entries or fallback to empty list

  // Secondary constructor to clone an existing journal
  Journal.cloneFrom({
    required this.name, // Name of the journal
    required List<JournalEntry> entries, // Existing entries to clone
    Isar? isar, // Optional Isar instance for the cloned journal
  })  : _entries = List.from(entries), // Copy entries to avoid mutation
        _isar = isar;

  // Getter to provide a read-only copy of the journal entries
  List<JournalEntry> get entries => List.from(_entries);

  // Method to add or update a journal entry
  Future<void> upsertEntry(JournalEntry entry) async {
    if (_isar != null) {
      // Perform database transaction if Isar is available
      await _isar.writeTxn(() async {
        await _isar.collection<JournalEntry>().put(entry); // Save the entry to the database
      });
    }

    // Find the index of the entry in the in-memory list
    final index = _entries.indexWhere((e) => e.id == entry.id);

    if (index == -1) {
      // Add new entry if it doesn't exist in the list
      _entries.add(entry);
    } else {
      // Update existing entry in the list
      _entries[index] = entry;
    }
  }

  // Method to clone the current journal instance
  Journal clone() {
    return Journal.cloneFrom(
      name: name, // Keep the same name
      entries: _entries, // Clone the entries
      isar: _isar, // Retain the Isar instance
    );
  }
}
