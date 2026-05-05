import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> signInWithGoogle();
  Future<UserCredential> signInWithEmailAndPassword(String email, String password);
  Future<UserCredential> register(String email, String password);
  Future<void> signOut() ;
}