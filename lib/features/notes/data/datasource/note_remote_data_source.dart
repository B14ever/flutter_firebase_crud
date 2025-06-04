// lib/data/datasources/note_remote_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class NoteRemoteDataSource {
  Stream<List<Map<String, dynamic>>> getNotes();
  Future<void> createNote(Map<String, dynamic> note);
  Future<void> updateNote(Map<String, dynamic> note);
  Future<void> deleteNote(String id);
}

class NoteRemoteDataSourceImpl implements NoteRemoteDataSource {
  final FirebaseFirestore firestore;

  NoteRemoteDataSourceImpl({required this.firestore});

  @override
  Stream<List<Map<String, dynamic>>> getNotes() {
    return firestore
        .collection('notes')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Future<void> createNote(Map<String, dynamic> note) async {
    await firestore.collection('notes').doc(note['id']).set(note);
  }

  @override
  Future<void> updateNote(Map<String, dynamic> note) async {
    await firestore.collection('notes').doc(note['id']).update(note);
  }

  @override
  Future<void> deleteNote(String id) async {
    await firestore.collection('notes').doc(id).delete();
  }
}