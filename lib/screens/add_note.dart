import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/screens/notes_list.dart';
import 'package:note_app/state/state_notifier.dart';

class AddNote extends ConsumerWidget {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _title = TextEditingController();
    final _content = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Hive Note',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
        child: Column(
          children: [
            TextField(
              controller: _title,
              maxLines: null,
              decoration: const InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: UnderlineInputBorder()),
            ),
            TextField(
              controller: _content,
              maxLines: null,
              decoration: const InputDecoration(
                  hintText: "Content",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: UnderlineInputBorder()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: () {
          final title = _title.text;
          final content = _content.text;
          _title.clear();
          _content.clear();
          ref.read(notesProvider.notifier).save(title, content);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NotesList()));
        },
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
