import 'package:ecommerce_app/core/error_handling/result_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<ResultState<UserCredential>> signInWithGoogle();
  Future<ResultState<UserCredential>> signInWithEmailAndPassword(String email, String password);
  Future<ResultState<UserCredential>> register(String email, String password);
  Future<void> signOut() ;
}