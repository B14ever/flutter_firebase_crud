import 'package:flutter_firebase_crud/features/notes/domain/repositories/note_repository.dart';

class DeleteNoteUseCase {
  final NoteRepository repository;

  DeleteNoteUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteNote(id);
  }
}