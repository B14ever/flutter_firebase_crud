import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_crud/features/notes/presentation/bloc/active_users/active_users_bloc.dart';
import 'package:flutter_firebase_crud/features/notes/presentation/bloc/note/note_bloc.dart';
import 'package:flutter_firebase_crud/features/notes/presentation/page/note_page.dart';
import 'package:flutter_firebase_crud/injection_container.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final getIt = GetIt.instance;
final GoRouter screenrouter = GoRouter(
  observers: [routeObserver],
  routes: [
    GoRoute(
      name: '/',
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          MaterialPage<void>(
        key: state.pageKey,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<NoteBloc>(
              create: (context) => serviceLocator<NoteBloc>(),
            ),
            BlocProvider<ActiveUsersBloc>(
              create: (context) => serviceLocator<ActiveUsersBloc>(),
            ),
          ],
          child: const NotePage(),
        ),
      ),
    ),
  ],
);
