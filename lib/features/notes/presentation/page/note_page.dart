import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_crud/core/constant/color.dart';
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
  String? _currentUserId;
  @override
  void initState() {
    super.initState();
    _currentUserId = FirebaseAuth.instance.currentUser?.uid;
    context.read<NoteBloc>().add(LoadNotes());
    context.read<ActiveUsersBloc>().add(StartTrackingPresence());
  }

  @override
  void dispose() {
    context.read<ActiveUsersBloc>().add(StopTrackingPresence());
    super.dispose();
  }

  void _showAddNoteModal() {
    final noteBloc = context.read<NoteBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) {
        return BlocProvider.value(
          value: noteBloc,
          child: const AddNoteModal(),
        );
      },
    );
  }

  void _showEditNoteModal(NoteEntits noteToEdit) {
    final noteBloc = context.read<NoteBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) {
        return BlocProvider.value(
          value: noteBloc,
          child: EditNoteModal(noteToEdit: noteToEdit),
        );
      },
    );
  }

  void _showDeleteConfirmationModal(String noteId) {
    final noteBloc = context.read<NoteBloc>();

    showModalBottomSheet(
      context: context,
      builder: (modalContext) {
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
        title: Text('Notes', style: Theme.of(context).textTheme.headlineLarge),
        actions: [
          BlocBuilder<ActiveUsersBloc, ActiveUsersState>(
            builder: (context, state) {
              if (state is ActiveUsersUpdated) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Chip(
                    label: Text('${state.count} active',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium), // Use bodyMedium for chip text
                    avatar: const Icon(Icons.people,
                        color: AppColors
                            .primaryAccent), // Use primaryAccent for icon
                    backgroundColor: AppColors.secondaryAccent
                        .withOpacity(0.2), // Use the themed chip background
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
              SnackBar(
                content: Text(state.errorMessage ?? 'Error occurred',
                    style: const TextStyle(
                        color: Colors.white)), // Ensure text is visible
                backgroundColor: AppColors.errorColor,
                behavior: SnackBarBehavior.floating, // Often looks better
                duration: const Duration(seconds: 3),
              ),
            );
            context.read<NoteBloc>().add(ClearMessages());
          } else if (state.status == NoteStatus.success &&
              state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!,
                    style: const TextStyle(color: Colors.white)),
                backgroundColor: AppColors.successColor,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(
                    seconds: 2), // Success messages can be shorter
              ),
            );
            context.read<NoteBloc>().add(ClearMessages());
          }
        },
        builder: (context, state) {
          if (state.status == NoteStatus.initial ||
              state.status == NoteStatus.loading) {
            return const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryAccent), // Spinner color
            ));
          }

          final notes = state.notes;
          if (notes.isEmpty) {
            return Center(
              child: Text('No notes yet. Add your first note!',
                  style: Theme.of(context).textTheme.bodyMedium),
            );
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              // Determine if the current note belongs to the current user
              final isCurrentUserNote =
                  (_currentUserId != null && note.userId == _currentUserId);
              final userDisplayName =
                  isCurrentUserNote ? 'You' : 'Anonymous User';
              final avatarColor = isCurrentUserNote
                  ? AppColors.primaryAccent.withOpacity(0.7)
                  : Colors.grey.shade400;
              return Dismissible(
                key: Key(note.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: AppColors
                      .errorColor, // Use error color for dismiss background
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    _showDeleteConfirmationModal(note.id);
                    return false;
                  }
                  return false;
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundColor: avatarColor,
                              child: Icon(
                                isCurrentUserNote
                                    ? Icons.person
                                    : Icons.person_off,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              userDisplayName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: isCurrentUserNote
                                        ? AppColors.primaryAccent
                                        : AppColors.secondaryText,
                                    fontWeight: isCurrentUserNote
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Title:',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.secondaryText,
                                  ),
                        ),
                        Text(
                          note.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Description:',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.secondaryText,
                                  ),
                        ),
                        Text(
                          note.content,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit,
                              color: AppColors.primaryAccent),
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
