class NoteEntits {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;

  NoteEntits({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });
    NoteEntits copyWith({
    DateTime? createdAt,
    String? id,
    String? title,
    String? content,
  }) {
    return NoteEntits(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  @override
  List<Object?> get props => [id, title, content];
}