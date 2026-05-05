import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/auth_repository/auth_repositroy.dart';
import '../../data/user_repository/user_repositroy.dart';
import '../../model/user_model.dart';



class AuthViewModel extends GetxController {
  final AuthRepository authRepo;
  final UserRepository userRepo;

  AuthViewModel(this.authRepo, this.userRepo);

  String email = '';
  String password = '';
  String name = '';
  RxBool isLoading = false.obs;

  Rxn<User> firebaseUser = Rxn<User>();

  bool get isLoggedIn => firebaseUser.value != null;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;

    final credential = await authRepo.signInWithGoogle();
    isLoading.value = false;
    _saveUser(credential);
  }

  Future<void> loginWithEmailAndPassword() async {
    try {
      isLoading.value = true;

      await authRepo.signInWithEmailAndPassword(email, password);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUpWithEmail() async {
    try {
      isLoading.value = true;

      final credential = await authRepo.register(email, password);
      isLoading.value = false;

      _saveUser(credential);

      Get.snackbar("Success", "Account created successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> register() async {
    final credential = await authRepo.register(email, password);
    _saveUser(credential);
  }

  void _saveUser(UserCredential userCredential) {
    final user = userCredential.user!;

    final resolvedName = name.isNotEmpty ? name : (user.displayName ?? "User");

    final userModel = UserModel(
      id: user.uid,
      name: resolvedName,
      email: user.email ?? '',
      pic: user.photoURL ?? '',
    );

    userRepo.saveUser(userModel);
  }

  Future<void> signOut() async {
    try {
      await authRepo.signOut();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
  Future<void>googlesignin() async {
  }
}
