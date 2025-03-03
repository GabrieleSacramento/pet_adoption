import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_adoption/failure/failure_erros.dart';
import 'package:pet_adoption/src/modules/Auth/domain/entities/user_authentication_entity.dart';

abstract class UserAuthenticationUseCase {
  Future<Either<Failure, User>> login(UserAuthenticationEntity user);
  Future<Either<Failure, User>> signup(UserAuthenticationEntity user);
}
