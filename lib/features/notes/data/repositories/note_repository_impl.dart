import 'package:flutter_firebase_crud/features/notes/data/datasource/note_remote_data_source.dart';
import 'package:flutter_firebase_crud/features/notes/data/models/note_model.dart';
import 'package:flutter_firebase_crud/features/notes/domain/entities/note_entits.dart';
import 'package:flutter_firebase_crud/features/notes/domain/repositories/note_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteRemoteDataSource remoteDataSource;
  final FirebaseAuth firebaseAuth;

  NoteRepositoryImpl({required this.remoteDataSource, required this.firebaseAuth});

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
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception("User not authenticated to create note.");
    }

    await remoteDataSource.createNote(
      NoteModel(
        id: note.id,
        title: note.title,
        content: note.content,
        createdAt: note.createdAt,
        updatedDate: note.updatedDate, 
        userId: user.uid, 
      ).toJson(),
    );
  }

  @override
  Future<void> updateNote(NoteEntits note) async {
    final user = firebaseAuth.currentUser; 
    if (user == null) {
      throw Exception("User not authenticated to update note.");
    }
   
    await remoteDataSource.updateNote(
      NoteModel(
        id: note.id,
        title: note.title,
        content: note.content,
        createdAt: note.createdAt,
        updatedDate: note.updatedDate,
        userId: note.userId,
      ).toJson(),
    );
  }

  @override
  Future<void> deleteNote(String id) async {
    // Firestore rules will handle the ownership check when deleting.
    await remoteDataSource.deleteNote(id);
  }
}