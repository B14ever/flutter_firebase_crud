
import 'package:flutter_firebase_crud/features/notes/domain/entities/note_entits.dart';

class NoteModel extends NoteEntits {
  NoteModel({
    required String id,
    required String title,
    required String content,
    required DateTime createdAt,
  }) : super(
          id: id,
          title: title,
          content: content,
          createdAt: createdAt,
        );

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}