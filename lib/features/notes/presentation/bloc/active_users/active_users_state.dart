part of 'active_users_bloc.dart';


sealed class ActiveUsersState extends Equatable {
  const ActiveUsersState();

  @override
  List<Object> get props => [];
}


final class ActiveUsersInitial extends ActiveUsersState {}

final class ActiveUsersUpdated extends ActiveUsersState {
  final int count;

  const ActiveUsersUpdated({required this.count});

  @override
  List<Object> get props => [count];
}


final class ActiveUsersError extends ActiveUsersState {
  final String message;

  const ActiveUsersError(this.message);

  @override
  List<Object> get props => [message];
}