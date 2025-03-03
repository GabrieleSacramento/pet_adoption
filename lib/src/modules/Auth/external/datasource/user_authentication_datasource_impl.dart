import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_adoption/src/modules/Auth/domain/entities/user_authentication_entity.dart';
import 'package:pet_adoption/src/modules/Auth/infra/datasource/user_authentication_datasource.dart';

class UserAuthenticationDatasourceImpl implements UserAuthenticationDatasource {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Future<User> login(UserAuthenticationEntity user) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      User? firebaseUser = userCredential.user;

      return firebaseUser!;
    } on FirebaseAuthException catch (e) {
      throw Exception('Erro ao fazer login: ${e.message}');
    } catch (e) {
      throw Exception('Erro ao acessar SharedPreferences: $e');
    }
  }

  @override
  Future<User> signup(UserAuthenticationEntity user) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      return userCredential.user!;
    } catch (e) {
      rethrow;
    }
  }
}
