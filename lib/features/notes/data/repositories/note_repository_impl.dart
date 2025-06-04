// lib/data/repositories/note_repository_impl.dart
import 'package:flutter_firebase_crud/features/notes/data/datasource/note_remote_data_source.dart'; // Import the abstract class
import 'package:flutter_firebase_crud/features/notes/data/models/note_model.dart';
import 'package:flutter_firebase_crud/features/notes/domain/entities/note_entits.dart';
import 'package:flutter_firebase_crud/features/notes/domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  // CHANGE THIS LINE: from NoteRemoteDataSourceImpl to NoteRemoteDataSource
  final NoteRemoteDataSource remoteDataSource; 

  NoteRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<List<NoteEntits>> getNotes() {
    return remoteDataSource.getNotes().map((noteList) {
      return noteList
          .map((noteMap) => NoteModel.fromJson(noteMap))
          .toList();
    });
  }

  @override
  Future<void> createNote(NoteEntits note) async {
    await remoteDataSource.createNote(NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      createdAt: note.createdAt,
    ).toJson());
  }

  @override
  Future<void> updateNote(NoteEntits note) async {
    await remoteDataSource.updateNote(NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      createdAt: note.createdAt,
    ).toJson());
  }

  @override
  Future<void> deleteNote(String id) async {
    await remoteDataSource.deleteNote(id);
  }
}