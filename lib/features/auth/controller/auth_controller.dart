import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sayara_hub_app/routes/app_routes.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final rememberMe = false.obs;
  final isPasswordHidden = true.obs;

  // Email/Phone regex patterns
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

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    Get.snackbar('Success', 'Login successful!',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green.withOpacity(0.9), colorText: Colors.white);
    Get.offAllNamed(AppRoutes.home);
  }

  void loginWithGoogle() {
    Get.snackbar('Google Sign In', 'Google login initiated', snackPosition: SnackPosition.BOTTOM);
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

  void goToSignup() {

  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}