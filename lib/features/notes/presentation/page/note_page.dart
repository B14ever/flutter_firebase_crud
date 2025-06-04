// lib/features/notes/presentation/page/note_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_crud/features/notes/domain/entities/note_entits.dart';
import 'package:flutter_firebase_crud/features/notes/presentation/bloc/active_users/active_users_bloc.dart';
import 'package:flutter_firebase_crud/features/notes/presentation/bloc/note/note_bloc.dart';
import 'package:flutter_firebase_crud/features/notes/presentation/widgets/add_note_modal.dart';
import 'package:flutter_firebase_crud/features/notes/presentation/widgets/edit_note_modal.dart';
import 'package:flutter_firebase_crud/features/notes/presentation/widgets/delete_confirmation_modal.dart';


class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  void initState() {
    super.initState();
    context.read<NoteBloc>().add(LoadNotes());
    context.read<ActiveUsersBloc>().add(StartTrackingPresence());
  }

  @override
  void dispose() {
    context.read<ActiveUsersBloc>().add(StopTrackingPresence());
    super.dispose();
  }

  void _showAddNoteModal() {
    // Get the NoteBloc instance from the current context
    final noteBloc = context.read<NoteBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) { // Use a different name like modalContext to avoid confusion
        // Provide the existing NoteBloc to the modal's subtree
        return BlocProvider.value(
          value: noteBloc,
          child: const AddNoteModal(),
        );
      },
    );
  }

  void _showEditNoteModal(NoteEntits noteToEdit) {
    // Get the NoteBloc instance from the current context
    final noteBloc = context.read<NoteBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) { // Use modalContext
        // Provide the existing NoteBloc to the modal's subtree
        return BlocProvider.value(
          value: noteBloc,
          child: EditNoteModal(noteToEdit: noteToEdit),
        );
      },
    );
  }

  void _showDeleteConfirmationModal(String noteId) {
    // Get the NoteBloc instance from the current context
    final noteBloc = context.read<NoteBloc>();

    showModalBottomSheet(
      context: context,
      builder: (modalContext) { // Use modalContext
        // Provide the existing NoteBloc to the modal's subtree
        return BlocProvider.value(
          value: noteBloc,
          child: DeleteConfirmationModal(noteId: noteId),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evergreen Notes'),
        actions: [
          BlocBuilder<ActiveUsersBloc, ActiveUsersState>(
            builder: (context, state) {
              if (state is ActiveUsersUpdated) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Chip(
                    label: Text('${state.count} active'),
                    avatar: const Icon(Icons.people, color: Colors.blueAccent),
                    backgroundColor: Colors.blue.shade50,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state) {
          if (state.status == NoteStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Error occurred')),
            );
          }
        },
        builder: (context, state) {
          if (state.status == NoteStatus.initial ||
              state.status == NoteStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final notes = state.notes;
          if (notes.isEmpty) {
            return const Center(child: Text('No notes yet. Add your first note!'));
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Dismissible(
                key: Key(note.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    _showDeleteConfirmationModal(note.id);
                    return false; // Prevent immediate dismissal; wait for modal confirmation
                  }
                  return false;
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      note.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(note.content),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showEditNoteModal(note),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNoteModal(),
        child: const Icon(Icons.add),
      ),
    );
  }
}