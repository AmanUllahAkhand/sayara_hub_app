import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_text_view.dart';

class ProfileController extends GetxController {
  final RxBool pushNotificationEnabled = true.obs;

  void togglePushNotification(bool value) {
    pushNotificationEnabled.value = value;
  }

  void onChangePassword() {
    // Navigate to change password screen later
    Get.snackbar('Coming Soon', 'Change Password feature');
  }

  void signOut() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: CustomTextView(
          text: 'Sign Out?',
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        content: CustomTextView(
          text: 'Are you sure you want to sign out?',
          color: AppColors.textSecondary,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: CustomTextView(text: 'Cancel', color: AppColors.primary),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // Navigate to login and clear stack
              Get.offAllNamed('/login');
            },
            child: CustomTextView(text: 'Sign Out', color: Colors.red),
          ),
        ],
      ),
    );
  }
}