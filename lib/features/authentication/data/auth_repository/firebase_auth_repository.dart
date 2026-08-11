import 'package:ecommerce_app/core/error_handling/network_exceptions.dart';
import 'package:ecommerce_app/core/error_handling/result_state.dart';
import 'package:ecommerce_app/features/authentication/data/auth_repository/auth_repositroy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';



class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthRepository(this._auth, this._googleSignIn);

  @override
  Future<ResultState<UserCredential>> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();

      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return const ResultState.failure(
          NetworkExceptions.requestCancelled(),
        );
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return ResultState.success(userCredential);
    } catch (e) {
      return ResultState.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ResultState<UserCredential>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return ResultState.success(userCredential);
    } catch (e) {
      return ResultState.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ResultState<UserCredential>> register(
      String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return ResultState.success(userCredential);
    } catch (e) {
      return ResultState.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ResultState<void>> signOut() async {
    try {
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
      await _auth.signOut();
      return const ResultState.success(null);
    } catch (e) {
      return ResultState.failure(NetworkExceptions.getDioException(e));
    }
  }
}