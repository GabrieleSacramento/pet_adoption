import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_adoption/src/modules/Auth/domain/entities/user_authentication_entity.dart';

abstract class UserAuthenticationDatasource {
  Future<User> login(UserAuthenticationEntity user);
  Future<User> signup(UserAuthenticationEntity user);
}
