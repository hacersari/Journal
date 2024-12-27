
import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';

class EntryView extends StatefulWidget {
  final JournalEntry entry;

  const EntryView({super.key, required this.entry});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView> {
  final _formKey = GlobalKey<FormState>();
  String currentText = '';
  String currentFeeling = '';
  int currentRating = 0;

  @override
  void initState() {
    super.initState();
    currentText = widget.entry.text;
    currentFeeling = widget.entry.feelingCategory;
    currentRating = widget.entry.rateTheDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Entry'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save), // Save button
            onPressed: () => _popBack(context), // Save and return to the previous screen
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Entry Text Form Field
              TextFormField(
                initialValue: currentText,
                decoration: const InputDecoration(labelText: 'Entry Text'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) => currentText = value ?? '',
              ),
              const SizedBox(height: 16), // Add spacing

              // Feeling Text Form Field
              TextFormField(
                initialValue: currentFeeling,
                decoration: const InputDecoration(labelText: 'Feeling'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a feeling';
                  }
                  return null;
                },
                onSaved: (value) => currentFeeling = value ?? '',
              ),
              const SizedBox(height: 16), // Add spacing

              // Day Rating Form Field
              TextFormField(
                initialValue: currentRating.toString(),
                decoration: const InputDecoration(labelText: 'Rate the Day (0-5)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final intValue = int.tryParse(value ?? '');
                  if (intValue == null || intValue < 0 || intValue > 5) {
                    return 'Please enter a valid rating between 0 and 5';
                  }
                  return null;
                },
                onSaved: (value) => currentRating = int.tryParse(value ?? '0') ?? 0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Save the updated entry and pop back to the previous screen
  void _popBack(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save(); // Save all fields

      final updatedEntry = JournalEntry.withUpdatedText(
        widget.entry,
        currentText,
        currentFeeling,
        currentRating,
      );

      Navigator.pop(context, updatedEntry); // Pass the updated entry back
    }
  }
}
