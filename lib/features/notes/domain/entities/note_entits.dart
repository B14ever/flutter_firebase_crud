class NoteEntits {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedDate;
  final String userId; 

  NoteEntits({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.updatedDate,
    required this.userId,
  });

  NoteEntits copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedDate,
    String? title,
    String? content,
    String? userId, 
  }) {
    return NoteEntits(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedDate: updatedDate ?? this.updatedDate,
      title: title ?? this.title,
      content: content ?? this.content,
      userId: userId ?? this.userId, 
    );
  }

  @override
  List<Object?> get props => [id, createdAt, updatedDate, title, content, userId];
}