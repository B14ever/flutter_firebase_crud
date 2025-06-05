import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_crud/features/notes/presentation/bloc/note/note_bloc.dart';

class DeleteConfirmationModal extends StatelessWidget {
  final String noteId;

  const DeleteConfirmationModal({super.key, required this.noteId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Confirm Deletion',
            style: Theme.of(context)
                .textTheme
                .titleLarge, // Uses themed text style
          ),
          const SizedBox(height: 20),
          Text(
            'Are you sure you want to delete this note? This action cannot be undone.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium, // Uses themed text style
            textAlign: TextAlign.center, // Center align for better readability
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Cancel
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<NoteBloc>().add(DeleteNote(noteId));
                  Navigator.pop(context); // Close the modal
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
