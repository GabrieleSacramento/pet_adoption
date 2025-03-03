import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/src/modules/Auth/domain/entities/user_authentication_entity.dart';
import 'package:pet_adoption/src/modules/Auth/domain/use_cases/user_authentication_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_authentication_state.dart';

class UserAuthenticationCubit extends Cubit<UserAuthenticationState> {
  final UserAuthenticationUseCase userAuthenticationUseCase;
  UserAuthenticationCubit({required this.userAuthenticationUseCase})
      : super(UserAuthenticationInitial());

  void signUp(UserAuthenticationEntity userAuthenticationEntity) async {
    emit(UserAuthenticationLoading());

    try {
      final result =
          await userAuthenticationUseCase.login(userAuthenticationEntity);
      final sp = await SharedPreferences.getInstance();

      result.fold(
        (l) => emit(UserAuthenticationError(message: l.message!)),
        (r) async {
          String? token = await r.getIdToken();
          await sp.setString('token', '$token');
          emit(UserAuthenticationSuccess(user: r));
        },
      );
    } on FirebaseAuthException catch (e) {
      emit(UserAuthenticationError(message: e.message!));
    }
  }

  void checkAuthentication() async {
    final sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');

    if (token != null) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        emit(UserAuthenticationSuccess(user: user));
      } else {
        emit(UserAuthenticationInitial());
      }
    } else {
      emit(UserAuthenticationInitial());
    }
  }

  void signIn(UserAuthenticationEntity userAuthenticationEntity) async {
    emit(UserAuthenticationLoading());

    try {
      final result =
          await userAuthenticationUseCase.login(userAuthenticationEntity);
      final sp = await SharedPreferences.getInstance();

      result.fold(
        (l) => emit(UserAuthenticationError(message: l.message!)),
        (r) async {
          String? token = await r.getIdToken();
          await sp.setString('token', '$token');
          emit(UserAuthenticationSuccess(user: r));
        },
      );
    } on FirebaseAuthException catch (e) {
      emit(UserAuthenticationError(message: e.message!));
    }
  }
}
