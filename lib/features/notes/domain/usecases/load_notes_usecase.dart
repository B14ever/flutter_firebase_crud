import 'package:flutter_firebase_crud/features/notes/domain/entities/note_entits.dart';
import 'package:flutter_firebase_crud/features/notes/domain/repositories/note_repository.dart';

class LoadNotesUseCase {
  final NoteRepository repository;

  LoadNotesUseCase(this.repository);

  Stream<List<NoteEntits>> call() {
    return repository.getNotes();
  }
}