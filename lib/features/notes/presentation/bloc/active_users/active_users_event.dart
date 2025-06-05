part of 'active_users_bloc.dart';

abstract class ActiveUsersEvent extends Equatable {
  const ActiveUsersEvent();

  @override
  List<Object> get props => [];
}

class StartTrackingPresence extends ActiveUsersEvent {}

class StopTrackingPresence extends ActiveUsersEvent {}

class ActiveUsersCountChanged extends ActiveUsersEvent {
  final int count;

  const ActiveUsersCountChanged(this.count);

  @override
  List<Object> get props => [count];
}