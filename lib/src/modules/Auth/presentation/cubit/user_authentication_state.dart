part of 'user_authentication_cubit.dart';

@immutable
sealed class UserAuthenticationState {}

final class UserAuthenticationInitial extends UserAuthenticationState {}

final class UserAuthenticationLoading extends UserAuthenticationState {}

final class UserAuthenticationSuccess extends UserAuthenticationState {
  final User user;

  UserAuthenticationSuccess({required this.user});
}

final class UserAuthenticationError extends UserAuthenticationState {
  final String message;

  UserAuthenticationError({required this.message});
}
