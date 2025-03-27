import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:temwin_front_app/Core/utils/hive_boxes.dart';
import 'package:temwin_front_app/Domain/UseCases/Auth/auth_usecases.dart';
import 'package:temwin_front_app/Domain/entities/user_data_entity.dart';
import 'package:temwin_front_app/Domain/entities/user_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecases authUsecases;

  late Box _authBox;
  StreamSubscription? _subscription;

  AuthBloc({
    required this.authUsecases,
  }) : super(AuthInitial()) {
    on<AuthInit>(_onAuthInit);
    on<SignIn>(_onSignIn);
    on<SignOut>(_onSignOut);
  }

  void _onSignOut(SignOut event, Emitter<AuthState> emit) async {
    if (event.makeServerRequest) {
      emit(UnAuthenticating());

      final result = await authUsecases.signOut(event.removeTokenOnly);

      result.fold((l) => emit(AuthError(errorMessage: l.message)), (r) {
        emit(UnAuthenticated2());
      });
    } else {
      emit(UnAuthenticated());
    }
  }

  void _onAuthInit(AuthInit event, Emitter<AuthState> emit) async {
    final result = await authUsecases.authInit();

    result.fold((l) => emit(UnAuthenticated()), (r) {
      //emit state
      emit(Authenticated(userDataEntity: r));
    });

    _authBox = await Hive.openBox(HiveBox.TOKEN_BOX);

    // // Listen for changes in the Hive box
    // // Listen for changes in the Hive box asynchronously
    await _subscribeToAuthBoxChanges(emit);
  }

  // Separate async function to handle Hive subscription
  Future<void> _subscribeToAuthBoxChanges(Emitter<AuthState> emit) async {
    _subscription = _authBox.watch().listen((BoxEvent event) async {
      if (event.key == HiveBox.TOKEN_BOX && event.deleted) {
        if (state is! UnAuthenticated2) {
          if (!isClosed) {
            // emit(UnAuthenticated());
            add(SignOut(
                makeServerRequest: false)); // Token deleted, user is logged out
          }
        }
      }
    });
  }

  void _onSignIn(SignIn event, Emitter<AuthState> emit) async {
    emit(Authenticating());

    debugPrint("in _onSignIn bloc");
    debugPrint("email : ${event.userCreds.email}");
    debugPrint("password : ${event.userCreds.password}");

    final result = await authUsecases.signIn(userCreds: event.userCreds);

    result.fold((l) {
      debugPrint('auth error : ${l.message}');
      emit(AuthError(errorMessage: l.message));
    }, (r) {
      //emit state
      emit(Authenticated(userDataEntity: r));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel(); // Cancel the subscription
    return super.close();
  }
}
