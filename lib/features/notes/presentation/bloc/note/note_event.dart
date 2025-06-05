part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class LoadNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final NoteEntits note;
  const AddNote(this.note);
}

class UpdateNote extends NoteEvent {
  final NoteEntits note;
  const UpdateNote(this.note);
}

class DeleteNote extends NoteEvent {
  final String id;
  const DeleteNote(this.id);
}

class ClearMessages extends NoteEvent {}
