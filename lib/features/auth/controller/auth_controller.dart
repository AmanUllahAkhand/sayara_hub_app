import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sayara_hub_app/routes/app_routes.dart';
import '../../../core/services/firebase_auth_service.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final rememberMe = false.obs;
  final isPasswordHidden = true.obs;

  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final _phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

  void toggleRememberMe(bool value) => rememberMe.value = value;
  void togglePasswordVisibility() => isPasswordHidden.value = !isPasswordHidden.value;

  bool _isValidEmailOrPhone(String input) {
    final trimmed = input.trim();
    return _emailRegex.hasMatch(trimmed) || _phoneRegex.hasMatch(trimmed.replaceAll(' ', ''));
  }

  void login() async {
    final emailOrPhone = emailController.text.trim();
    final password = passwordController.text;

    if (emailOrPhone.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email/Phone and password are required',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red.withOpacity(0.9), colorText: Colors.white);
      return;
    }

    if (!_isValidEmailOrPhone(emailOrPhone)) {
      Get.snackbar('Invalid Input', 'Please enter a valid email or phone number',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.orange.withOpacity(0.9), colorText: Colors.white);
      return;
    }

    if (password.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red.withOpacity(0.9), colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    Get.snackbar('Success', 'Login successful!',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green.withOpacity(0.9), colorText: Colors.white);
    Get.offAllNamed(AppRoutes.home);
  }

  /// 🔹 GOOGLE LOGIN
  void loginWithGoogle() async {
    isLoading.value = true;

    try {
      final userCredential = await FirebaseAuthService.signInWithGoogle();

      if (userCredential != null) {
        final user = userCredential.user;

        // 🔹 FIREBASE USER INFO
        debugPrint('===== FIREBASE USER =====');
        debugPrint('UID: ${user?.uid}');
        debugPrint('Name: ${user?.displayName}');
        debugPrint('Email: ${user?.email}');
        debugPrint('Photo URL: ${user?.photoURL}');
        debugPrint('Phone: ${user?.phoneNumber}');
        debugPrint('Email Verified: ${user?.emailVerified}');
        debugPrint('Provider Data: ${user?.providerData.map((e) => e.providerId).toList()}');

        // 🔹 If you want to get ID Token
        final idToken = await user?.getIdToken();
        debugPrint('ID Token: $idToken');

        Get.snackbar(
          'Success',
          'Logged in as ${user?.displayName}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.9),
          colorText: Colors.white,
        );

        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.snackbar(
          'Cancelled',
          'Google sign-in was cancelled by the user',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange.withOpacity(0.9),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Google sign-in failed: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }


  void loginWithFacebook() {
    Get.snackbar('Facebook Sign In', 'Facebook login initiated', snackPosition: SnackPosition.BOTTOM);
  }

  void loginWithApple() {
    Get.snackbar('Apple Sign In', 'Apple login initiated', snackPosition: SnackPosition.BOTTOM);
  }

  void forgotPassword() {
    Get.snackbar('Forgot Password', 'Reset password flow coming soon', snackPosition: SnackPosition.BOTTOM);
  }

  void goToSignup() {}

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
