import 'package:isar/isar.dart';
part 'journal_entry.g.dart';

/// Represents a journal entry with properties such as ID, text, timestamps,
/// feeling category, and a rating for the day.
@collection
class JournalEntry {
  /// Unique identifier for the journal entry (optional for new entries).
  final Id? id;

  /// The main text content of the journal entry.
  final String text;

  /// The timestamp when the entry was last updated.
  final DateTime updatedAt;

  /// The timestamp when the entry was originally created.
  final DateTime createdAt;

  /// A category representing the feeling associated with this entry.
  final String feelingCategory;

  /// A rating for the day (0–5), where 0 is the lowest and 5 is the highest.
  final int rateTheDay;

  /// Factory constructor for creating a new journal entry with default values.
  /// This ensures accessibility by providing default values and meaningful fallback behavior.
  ///
  /// - [text]: The main text content of the entry (default: an empty string).
  /// - [feelingCategory]: The category for the feeling associated with the entry (default: 'no feelings').
  /// - [rateTheDay]: A rating for the day (default: 0).
  factory JournalEntry.fromText({
    String text = '',
    String feelingCategory = 'no feelings',
    int rateTheDay = 0,
  }) {
    final when =
        DateTime.now(); // Current timestamp for creation and update times.
    return JournalEntry(
      id: null, // New entries won't have an ID until saved to the database.
      text: text,
      feelingCategory: feelingCategory,
      rateTheDay: rateTheDay,
      updatedAt: when,
      createdAt: when,
    );
  }

  /// Main constructor for creating a journal entry with explicit values.
  ///
  /// - [id]: The unique identifier for the entry (optional).
  /// - [text]: The main text content of the entry.
  /// - [updatedAt]: The timestamp for the last update.
  /// - [createdAt]: The timestamp for the entry's creation.
  /// - [feelingCategory]: The category for the feeling associated with the entry (default: 'no feelings').
  /// - [rateTheDay]: A rating for the day (default: 0).
  JournalEntry({
    this.id,
    required this.text,
    required this.updatedAt,
    required this.createdAt,
    this.feelingCategory =
        'no feelings', // Default value ensures accessibility.
    this.rateTheDay = 0, // Default value ensures accessibility.
  });

  /// Constructor for creating an updated journal entry, ensuring immutability of the original entry.
  ///
  /// - [entry]: The existing entry to update.
  /// - [newText]: The new text content for the entry.
  /// - [newFeeling]: The new feeling category for the entry.
  /// - [newRating]: The new rating for the day (must be between 0 and 5).
  ///
  /// This constructor ensures that the original entry remains unchanged by creating
  /// a new entry instance with updated values while preserving creation time and ID.
  // Constructor to create an updated journal entry
  JournalEntry.withUpdatedText(
      JournalEntry entry,
      String
          newText, // Keep this required for now as it seems to be always expected
      [String? newFeeling,
      int? newRating] // Make these optional
      )
      : id = entry.id,
        createdAt = entry.createdAt,
        updatedAt = DateTime.now(),
        text = newText,
        feelingCategory =
            newFeeling ?? entry.feelingCategory, // Fallback to original value
        rateTheDay =
            newRating ?? entry.rateTheDay; // Fallback to original value
}
