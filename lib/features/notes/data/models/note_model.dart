import 'package:cloud_firestore/cloud_firestore.dart'; 
import '../../domain/entities/note_entits.dart';

class NoteModel extends NoteEntits {
  NoteModel({
    required String id,
    required String title,
    required String content,
    required DateTime createdAt,
    DateTime? updatedDate,
    required String userId,
  }) : super(
          id: id,
          title: title,
          content: content,
          createdAt: createdAt,
          updatedDate: updatedDate,
          userId: userId,
        );

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedDate: (json['updatedDate'] as Timestamp?)?.toDate(),
      userId: json['userId'] as String, 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedDate': updatedDate != null ? Timestamp.fromDate(updatedDate!) : null,
      'userId': userId,
    };
  }
}