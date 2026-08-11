import 'package:ecommerce_app/core/error_handling/network_exceptions.dart';
import 'package:ecommerce_app/core/error_handling/result_state.dart';
import 'package:ecommerce_app/features/authentication/data/auth_repository/auth_repositroy.dart';
import 'package:ecommerce_app/features/authentication/data/user_repository/user_repositroy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/user_model.dart';

class AuthViewModel extends GetxController {
  final AuthRepository authRepo;
  final UserRepository userRepo;

  AuthViewModel(this.authRepo, this.userRepo);

  final passwordController = TextEditingController();

  String email = '';
  String password = '';
  String name = '';
  String phoneNumber = '';
  String fName = '';
  String lName = '';
  final loginFormKey = GlobalKey<FormState>();
  
  final signUpFormKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rxn<User> firebaseUser = Rxn<User>();

  bool get isLoggedIn => firebaseUser.value != null;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());

    ever(firebaseUser, (User? user) async {
      if (user != null) {
        try {
          await user.reload();
        } catch (_) {
          await signOut();
        }
      }
    });
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;

    final result = await authRepo.signInWithGoogle();

    result.when(
      success: (userCredential) async {
        await _saveUser(userCredential);
        isLoading.value = false;
      },
      failure: (error) {
        isLoading.value = false;
        final networkException = error;

        networkException.maybeWhen(
          requestCancelled: () {},
          orElse: () {
            _showSnackBar(
              "Google Sign-In Failed",
              networkException,
              isError: true,
            );
          },
        );
      },
    );
  }

  Future<void> loginWithEmailAndPassword() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    formKey.currentState?.save();

    isLoading.value = true;

    final result = await authRepo.signInWithEmailAndPassword(email, password);

    isLoading.value = false;

    result.when(
      success: (userCredential) {
        firebaseUser.value = userCredential.user;
      },
      failure: (error) {
        final networkException = error;
        _showSnackBar("Login Failed", networkException, isError: true);
      },
    );
  }

  Future<void> signUpWithEmail() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    formKey.currentState?.save();

    isLoading.value = true;

    final result = await authRepo.register(email, password);

    result.when(
      success: (userCredential) async {
        await _saveUser(userCredential);
        isLoading.value = false;
        Get.snackbar(
          "Success",
          "Account created successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(12),
        );
      },
      failure: (error) {
        isLoading.value = false;
        final networkException = error;
        _showSnackBar("Registration Failed", networkException, isError: true);
      },
    );
  }

  Future<void> _saveUser(UserCredential userCredential) async {
    final user = userCredential.user;
    if (user == null) return;

    final fullName = '$fName $lName'.trim();
    final resolvedName = fullName.isNotEmpty
        ? fullName
        : (name.isNotEmpty ? name : (user.displayName ?? "User"));

    final userModel = UserModel(
      id: user.uid,
      name: resolvedName,
      email: user.email ?? email,
      pic: user.photoURL ?? '',
      phoneNumber: phoneNumber,
      fName: fName,
      lName: lName,
    );

    final result = await userRepo.saveUser(userModel);

    result.when(
      success: (_) {},
      failure: (error) {
        final networkException = error;
        _showSnackBar("User Profile Error", networkException, isError: true);
      },
    );
  }

  Future<void> signOut() async {
    isLoading.value = true;
    try {
      await authRepo.signOut();
      firebaseUser.value = null;
    } catch (e) {
      Get.snackbar(
        "Sign Out Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _showSnackBar(
    String title,
    NetworkExceptions networkException, {
    bool isError = false,
  }) {
    final errorMessage = NetworkExceptions.getErrorMessage(networkException);

    Get.snackbar(
      title,
      errorMessage,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Colors.redAccent : Colors.black87,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 4),
    );
  }
}
