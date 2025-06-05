part of 'note_bloc.dart';

enum NoteStatus { initial, loading, success, failure }

class NoteState extends Equatable {
  final NoteStatus status;
  final List<NoteEntits> notes;
  final String? errorMessage;
  final String? successMessage;

  const NoteState({
    this.status = NoteStatus.initial,
    this.notes = const [],
    this.errorMessage,
    this.successMessage,
  });

  NoteState copyWith({
    NoteStatus? status,
    List<NoteEntits>? notes,
    String? successMessage,
    String? errorMessage,
    bool clearErrorMessage = false,
    bool clearSuccessMessage = false,
  }) {
    return NoteState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage:
          clearSuccessMessage ? null : successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [status, notes, errorMessage, successMessage];
}
