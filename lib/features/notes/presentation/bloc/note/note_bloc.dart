import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_crud/features/notes/domain/entities/note_entits.dart';
import 'package:flutter_firebase_crud/features/notes/domain/usecases/add_note_usecase.dart';
import 'package:flutter_firebase_crud/features/notes/domain/usecases/delete_note_usecase.dart';
import 'package:flutter_firebase_crud/features/notes/domain/usecases/load_notes_usecase.dart';
import 'package:flutter_firebase_crud/features/notes/domain/usecases/update_note_usecase.dart';
import 'package:flutter_firebase_crud/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(const NoteState()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
    on<ClearMessages>(_onClearMessages);
  }

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NoteState> emit) async {
    emit(state.copyWith(status: NoteStatus.loading));
    try {
      final loadNotesUseCase = serviceLocator<LoadNotesUseCase>();
      await emit.forEach<List<NoteEntits>>(
        loadNotesUseCase(),
        onData: (notes) => state.copyWith(
          status: NoteStatus.success,
          notes: notes,
        ),
        onError: (error, stackTrace) {
          print('Error loading notes: $error');
          print('Stack trace: $stackTrace');
          return state.copyWith(
            status: NoteStatus.failure,
            errorMessage: 'Failed to load notes: ${error.toString()}',
          );
        },
      );
    } catch (e, stackTrace) {
      print('Caught exception in _onLoadNotes: $e');
      print('Stack trace: $stackTrace');
      emit(state.copyWith(
        status: NoteStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onAddNote(AddNote event, Emitter<NoteState> emit) async {
    try {
      final addNoteUseCase = serviceLocator<AddNoteUseCase>();
      await addNoteUseCase(event.note);
      emit(state.copyWith(
        status: NoteStatus.success,
        successMessage: 'Note created successfully',
      ));
    } catch (e, stackTrace) {
      print('Caught exception in _onAddNote: $e');
      print('Stack trace: $stackTrace');
      String errorMessage = 'Failed to add note: ${e.toString()}';
      if (e is FirebaseException && e.code == 'permission-denied') {
        errorMessage = 'You do not have permission to add notes.';
      }
      emit(state.copyWith(
        status: NoteStatus.failure,
        errorMessage: errorMessage,
      ));
    }
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) async {
    try {
      final updateNoteUseCase = serviceLocator<UpdateNoteUseCase>();
      await updateNoteUseCase(event.note);
      emit(state.copyWith(
        status: NoteStatus.success,
        successMessage: 'Note Updated successfully',
      ));
    } on FirebaseException catch (e, stackTrace) {
      print(
          'Caught FirebaseException in _onUpdateNote: ${e.code} - ${e.message}');
      print('Stack trace: $stackTrace');
      if (e.code == 'permission-denied') {
        emit(state.copyWith(
          status: NoteStatus.failure,
          errorMessage: 'You cannot update a note that you did not create.',
        ));
      } else {
        emit(state.copyWith(
          status: NoteStatus.failure,
          errorMessage: 'Failed to update note: ${e.message ?? e.toString()}',
        ));
      }
    } catch (e, stackTrace) {
      print('Caught unexpected exception in _onUpdateNote: $e');
      print('Stack trace: $stackTrace');
      emit(state.copyWith(
        status: NoteStatus.failure,
        errorMessage: 'An unexpected error occurred: ${e.toString()}',
      ));
    }
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    try {
      final deleteNoteUseCase = serviceLocator<DeleteNoteUseCase>();
      await deleteNoteUseCase(event.id);
      emit(state.copyWith(
        status: NoteStatus.success,
        successMessage: 'Note deleted successfully',
      ));
    } on FirebaseException catch (e, stackTrace) {
      print(
          'Caught FirebaseException in _onDeleteNote: ${e.code} - ${e.message}');
      print('Stack trace: $stackTrace');
      if (e.code == 'permission-denied') {
        emit(state.copyWith(
          status: NoteStatus.failure,
          errorMessage: 'You cannot delete a note that you did not create.',
        ));
      } else {
        emit(state.copyWith(
          status: NoteStatus.failure,
          errorMessage: 'Failed to delete note: ${e.message ?? e.toString()}',
        ));
      }
    } catch (e, stackTrace) {
      print('Caught unexpected exception in _onDeleteNote: $e');
      print('Stack trace: $stackTrace');
      emit(state.copyWith(
        status: NoteStatus.failure,
        errorMessage: 'An unexpected error occurred: ${e.toString()}',
      ));
    }
  }

  void _onClearMessages(ClearMessages event, Emitter<NoteState> emit) {
    emit(state.copyWith(clearErrorMessage: true, clearSuccessMessage: true));
  }
}
