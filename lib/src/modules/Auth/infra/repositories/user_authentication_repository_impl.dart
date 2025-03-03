import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_adoption/failure/failure_erros.dart';
import 'package:pet_adoption/failure/repository_error.dart';
import 'package:pet_adoption/src/modules/Auth/domain/entities/user_authentication_entity.dart';
import 'package:pet_adoption/src/modules/Auth/domain/repositories/user_authentication_repository.dart';
import 'package:pet_adoption/src/modules/Auth/infra/datasource/user_authentication_datasource.dart';

class UserAuthenticationRepositoryImpl implements UserAuthenticationRepository {
  final UserAuthenticationDatasource datasource;

  UserAuthenticationRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, User>> login(UserAuthenticationEntity user) async {
    try {
      final result = await datasource.login(user);
      return Right(result);
    } catch (e) {
      return Left(RepositoryError().getError(e));
    }
  }

  @override
  Future<Either<Failure, User>> signup(UserAuthenticationEntity user) async {
    try {
      final result = await datasource.signup(user);
      return Right(result);
    } catch (e) {
      return Left(RepositoryError().getError(e));
    }
  }
}
