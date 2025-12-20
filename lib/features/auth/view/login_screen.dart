import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_svgs.dart';
import '../../../core/widgets/custom_text_view.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              // Title
              const CustomTextView(
                text: 'Welcome Back!',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),

              const SizedBox(height: 8),
              const CustomTextView(
                text: 'Your next opportunity is just a tap away.',
                textAlign: TextAlign.center,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),

              const SizedBox(height: 80),

              // Email/Phone Field
              _buildInputField(
                controller: controller.emailController,
                hint: 'Enter your email or phone',
                svgAsset: AppSvgs.email,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),

              // Password Field
              Obx(() => _buildInputField(
                controller: controller.passwordController,
                hint: 'Password',
                svgAsset: AppSvgs.password,
                obscureText: controller.isPasswordHidden.value,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordHidden.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 20,
                    color: AppColors.hintText,
                  ),
                  onPressed: controller.togglePasswordVisibility,
                ),
              )),

              const SizedBox(height: 12),

              // Remember Me & Forgot Password
              Row(
                children: [
                  Obx(() => Checkbox(
                    value: controller.rememberMe.value,
                    onChanged: (value) => controller.toggleRememberMe(value!),
                    activeColor: AppColors.primary,
                    checkColor: Colors.white,
                    side: const BorderSide(color: AppColors.primary),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )),
                  const CustomTextView(
                    text: 'Remember me',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintText,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: controller.forgotPassword,
                    child: const CustomTextView(
                      text: 'Forgot Password?',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.link,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Login Button
              Obx(() => SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value ? null : controller.login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.scaffoldBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )
                      : const CustomTextView(
                    text: 'Login',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.scaffoldBackground,
                  ),
                ),
              )),

              const SizedBox(height: 32),

              // Divider "or"
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('or', style: TextStyle(color: AppColors.textSecondary)),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 32),

              // Social Login Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(
                    svgAsset: AppSvgs.google,
                    onTap: controller.loginWithGoogle,
                  ),
                  const SizedBox(width: 20),
                  _buildSocialButton(
                    svgAsset: AppSvgs.facebook,
                    onTap: controller.loginWithFacebook,
                  ),
                  // Show Apple button only on iOS
                  if (Platform.isIOS) ...[
                    const SizedBox(width: 20),
                    _buildSocialButton(
                      svgAsset: AppSvgs.apple,
                      onTap: controller.loginWithApple,
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 48),

              // Signup Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomTextView(
                    text: "Don’t have an account? ",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                  TextButton(
                    onPressed: controller.goToSignup,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const CustomTextView(
                      text: 'Signup',
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required String svgAsset,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(14),
          child: SvgPicture.asset(
            svgAsset,
            colorFilter: const ColorFilter.mode(AppColors.hintText, BlendMode.srcIn),
            width: 20,
            height: 20,
          ),
        ),
        suffixIcon: suffixIcon,
        hintText: hint,
        hintStyle: const TextStyle(
          color: AppColors.hintText,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: AppColors.alpineWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      ),
    );
  }

  Widget _buildSocialButton({
    required String svgAsset,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 26,
        backgroundColor: AppColors.socialBackground,
        child: SvgPicture.asset(
          svgAsset,
          width: 26,
          height: 26,
        ),
      ),
    );
  }
}