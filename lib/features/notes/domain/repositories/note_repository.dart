import 'package:flutter_firebase_crud/features/notes/domain/entities/note_entits.dart';

abstract class NoteRepository {
  Stream<List<NoteEntits>> getNotes();
  Future<void> createNote(NoteEntits note);
  Future<void> updateNote(NoteEntits note);
  Future<void> deleteNote(String id);
}