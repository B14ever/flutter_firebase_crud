// lib/injection_container.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_firebase_crud/features/notes/domain/usecases/add_note_usecase.dart';
import 'package:flutter_firebase_crud/features/notes/domain/usecases/delete_note_usecase.dart';
import 'package:flutter_firebase_crud/features/notes/domain/usecases/load_notes_usecase.dart';
import 'package:flutter_firebase_crud/features/notes/domain/usecases/update_note_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_firebase_crud/features/notes/data/datasource/note_remote_data_source.dart';
import 'package:flutter_firebase_crud/features/notes/data/repositories/note_repository_impl.dart';
import 'package:flutter_firebase_crud/features/notes/domain/repositories/note_repository.dart';
import 'package:flutter_firebase_crud/features/notes/presentation/bloc/active_users/active_users_bloc.dart';
import 'package:flutter_firebase_crud/features/notes/presentation/bloc/note/note_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // BLoCs
  serviceLocator.registerFactory(() => NoteBloc());
  
  serviceLocator.registerFactory<ActiveUsersBloc>(() => ActiveUsersBloc(
        activeUsersRef: FirebaseDatabase.instance.ref('active_users'),
      )..add(StartTrackingPresence()));
  // Use Cases
  serviceLocator.registerLazySingleton(() => AddNoteUseCase(serviceLocator())); 
  serviceLocator.registerLazySingleton(() => DeleteNoteUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => LoadNotesUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => UpdateNoteUseCase(serviceLocator()));
  // Repositories
  serviceLocator.registerLazySingleton<NoteRepository>(() => NoteRepositoryImpl(
        remoteDataSource: serviceLocator(), // This expects NoteRemoteDataSource
      ));

  // Data sources - FIXED: Register abstract type with concrete implementation
  serviceLocator.registerLazySingleton<NoteRemoteDataSource>(
    () => NoteRemoteDataSourceImpl(firestore: FirebaseFirestore.instance),
  );
}