import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final notesProvider =
    StateNotifierProvider<NoteNotifier, List<Map<dynamic, dynamic>>>((ref) {
  return NoteNotifier();
});

class NoteNotifier extends StateNotifier<List<Map<dynamic, dynamic>>> {
  NoteNotifier() : super([]) {
    loadData();
  }
  late Box box;
  Future<void> loadData() async {
    box = Hive.box('database');
    final loadedData = box.get('notes', defaultValue: []);
    state = List<Map<dynamic, dynamic>>.from(loadedData);
  }

  void save(String title, String content) async {
    if (title.isNotEmpty || content.isNotEmpty) {
      final newNote = ({"title": title, "content": content});
      state = [...state, newNote];
      box.put('notes', state);
    }
  }

  void delete(int index) {
    state.removeAt(index);
    box.put('notes', state);
    state = [...state];
  }

  void edit(int index, String editedTitle, String editedContent) async {
    if (editedTitle.isNotEmpty || editedContent.isNotEmpty) {
      final newNote = ({"title": editedTitle, "content": editedContent});
      state[index] = newNote;
      box.put('notes', state);
      state = [...state];
    }
  }
}
