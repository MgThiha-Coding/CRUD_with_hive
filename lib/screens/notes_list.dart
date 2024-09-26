import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/screens/edit_note.dart';
import 'package:note_app/state/state_notifier.dart';

class NotesList extends ConsumerWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Change this to your desired color
        ),
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final data = notes[index];
            return Card(
              child: ListTile(
                title: Text(
                  data['title'] ?? '',
                  style: const TextStyle(color: Colors.blue, fontSize: 20),
                  maxLines: 1,
                ),
                subtitle: Text(
                  data['content'] ?? '',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 141, 139, 139),
                    fontSize: 18,
                  ),
                  maxLines: 3,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Pass the title and content to EditNote
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditNote(
                              index: index,
                              initialTitle: data['title'] ?? '',
                              initialContent: data['content'] ?? '',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Are you sure to Delete?',
                                style: TextStyle(color: Colors.red),
                              ),
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      ref
                                          .read(notesProvider.notifier)
                                          .delete(index);
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
