import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/state/state_notifier.dart';

class EditNote extends ConsumerWidget {
  final int index;
  final String initialTitle;
  final String initialContent;

  const EditNote({
    super.key,
    required this.index,
    required this.initialTitle,
    required this.initialContent,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize controllers with the existing note data
    final titleController = TextEditingController(text: initialTitle);
    final contentController = TextEditingController(text: initialContent);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Change this to your desired color
        ),
        actions: [
          IconButton(
            onPressed: () {
              final editedNote = titleController.text;
              final editedContent = contentController.text;
              ref
                  .read(notesProvider.notifier)
                  .edit(index, editedNote, editedContent);
              Navigator.pop(
                  context); // Return to the previous screen after saving
            },
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Edit Note',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(color: Colors.grey),
                border: UnderlineInputBorder(),
              ),
            ),
            TextField(
              controller: contentController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: "Content",
                hintStyle: TextStyle(color: Colors.grey),
                border: UnderlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
