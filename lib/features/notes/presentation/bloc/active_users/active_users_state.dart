// lib/presentation/bloc/active_users/active_users_state.dart
part of 'active_users_bloc.dart';

abstract class ActiveUsersState extends Equatable {
  const ActiveUsersState();

  @override
  List<Object> get props => [];
}

class ActiveUsersInitial extends ActiveUsersState {}

class ActiveUsersUpdated extends ActiveUsersState {
  final int count;

  const ActiveUsersUpdated({required this.count});

  @override
  List<Object> get props => [count];
}