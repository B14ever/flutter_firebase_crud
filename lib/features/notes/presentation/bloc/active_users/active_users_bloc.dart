
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

part 'active_users_event.dart';
part 'active_users_state.dart';

class ActiveUsersBloc extends Bloc<ActiveUsersEvent, ActiveUsersState> {
  final DatabaseReference activeUsersRef;
  DatabaseReference? _userRef;
  String? _sessionId;
  StreamSubscription<DatabaseEvent>? _subscription;

  ActiveUsersBloc({required this.activeUsersRef}) : super(ActiveUsersInitial()) {
    on<StartTrackingPresence>(_onStartTrackingPresence);
    on<StopTrackingPresence>(_onStopTrackingPresence);
    on<ActiveUsersCountChanged>(_onActiveUsersCountChanged);
  }

  Future<void> _onStartTrackingPresence(
    StartTrackingPresence event,
    Emitter<ActiveUsersState> emit,
  ) async {
    _sessionId = const Uuid().v4();
    _userRef = activeUsersRef.child(_sessionId!);
    
    try {
   
      await _userRef!.set(ServerValue.timestamp);
      
      _userRef!.onDisconnect().remove();
    } catch (e) {
   
      return;
    }


    _subscription?.cancel();

   
    _subscription = activeUsersRef.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        final Map<dynamic, dynamic> users = 
            event.snapshot.value as Map<dynamic, dynamic>;
        add(ActiveUsersCountChanged(users.length));
      } else {
        add(const ActiveUsersCountChanged(0));
      }
    });
  }

  Future<void> _onStopTrackingPresence(
    StopTrackingPresence event,
    Emitter<ActiveUsersState> emit,
  ) async {
    try {
      await _userRef?.remove();
    } catch (e) {
      // Handle error
    }
    _subscription?.cancel();
    _subscription = null;
    _userRef = null;
    _sessionId = null;
  }

  void _onActiveUsersCountChanged(
    ActiveUsersCountChanged event,
    Emitter<ActiveUsersState> emit,
  ) {
    emit(ActiveUsersUpdated(count: event.count));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    try {
      _userRef?.remove();
    } catch (e) {
      // Handle error
    }
    return super.close();
  }
}