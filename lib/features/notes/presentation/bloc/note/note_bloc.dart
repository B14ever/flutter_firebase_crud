// lib/presentation/bloc/note/note_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_crud/features/notes/domain/entities/note_entits.dart';
import 'package:flutter_firebase_crud/features/notes/domain/usecases/add_note_usecase.dart';
import 'package:flutter_firebase_crud/features/notes/domain/usecases/delete_note_usecase.dart';
import 'package:flutter_firebase_crud/features/notes/domain/usecases/load_notes_usecase.dart';
import 'package:flutter_firebase_crud/features/notes/domain/usecases/update_note_usecase.dart';
import 'package:flutter_firebase_crud/injection_container.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {

  NoteBloc() : super(const NoteState()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
  }

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NoteState> emit) async {
    emit(state.copyWith(status: NoteStatus.loading));
    try {
      final loadNotesUseCase = serviceLocator<LoadNotesUseCase>();
      await emit.forEach<List<NoteEntits>>(
        loadNotesUseCase(), // Call the use case
        onData: (notes) => state.copyWith(
          status: NoteStatus.success,
          notes: notes,
        ),
        onError: (_, __) => state.copyWith(
          status: NoteStatus.failure,
          errorMessage: 'Failed to load notes',
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: NoteStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onAddNote(AddNote event, Emitter<NoteState> emit) async {
    try {
      // Resolve the use case here
      final addNoteUseCase = serviceLocator<AddNoteUseCase>();
      await addNoteUseCase(event.note);
    } catch (e) {
      emit(state.copyWith(
        status: NoteStatus.failure,
        errorMessage: 'Failed to add note: ${e.toString()}',
      ));
    }
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) async {
    try {
      // Resolve the use case here
      final updateNoteUseCase = serviceLocator<UpdateNoteUseCase>();
      await updateNoteUseCase(event.note);
    } catch (e) {
      emit(state.copyWith(
        status: NoteStatus.failure,
        errorMessage: 'Failed to update note: ${e.toString()}',
      ));
    }
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    try {
      // Resolve the use case here
      final deleteNoteUseCase = serviceLocator<DeleteNoteUseCase>();
      await deleteNoteUseCase(event.id);
    } catch (e) {
      emit(state.copyWith(
        status: NoteStatus.failure,
        errorMessage: 'Failed to delete note: ${e.toString()}',
      ));
    }
  }
}