import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_adoption/failure/failure_erros.dart';
import 'package:pet_adoption/src/modules/Auth/domain/entities/user_authentication_entity.dart';
import 'package:pet_adoption/src/modules/Auth/domain/repositories/user_authentication_repository.dart';
import 'package:pet_adoption/src/modules/Auth/domain/use_cases/user_authentication_use_case.dart';

class UserAuthenticationUseCaseImpl implements UserAuthenticationUseCase {
  final UserAuthenticationRepository repository;

  UserAuthenticationUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, User>> login(UserAuthenticationEntity user) {
    return repository.login(user);
  }

  @override
  Future<Either<Failure, User>> signup(UserAuthenticationEntity user) {
    return repository.signup(user);
  }
}
