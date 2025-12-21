import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_svgs.dart';
import '../../../core/widgets/custom_text_view.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomTextView(
          text: 'Profile',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Avatar & Name
            ClipOval(
              child: SvgPicture.asset(
                AppSvgs.profileImage,
                width: 120,  // 2x radius for crisp rendering
                height: 120,
                fit: BoxFit.cover, // Ensures the SVG fills the circle properly
                placeholderBuilder: (context) => Container(
                  color: Colors.grey.shade200,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomTextView(
              text: 'Aman Ullah Akhand',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            const SizedBox(height: 12),

            // Email & Phone
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppSvgs.email, width: 15, height: 15, colorFilter: ColorFilter.mode(AppColors.hintText, BlendMode.srcIn)),
                const SizedBox(width: 5),
                CustomTextView(
                  text: 'nicolas@email.com',
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 15),
                SvgPicture.asset(AppSvgs.mobile, width: 15, height: 15, colorFilter: ColorFilter.mode(AppColors.hintText, BlendMode.srcIn)),
                const SizedBox(width: 5),
                CustomTextView(
                  text: '+1 (555) 123-4567',
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Settings Section
            Align(
              alignment: Alignment.centerLeft,
              child: CustomTextView(
                text: 'Settings',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            // Notifications Toggle
            _buildSettingItem(
              icon: AppSvgs.notification,
              title: 'Notifications',
              subtitle: 'Enable Push Notification',
              trailing: Obx(() => Switch(
                value: controller.pushNotificationEnabled.value,
                onChanged: controller.togglePushNotification,
                activeColor: AppColors.primary,
              )),
            ),

            const SizedBox(height: 12),

            // Change Password
            _buildSettingItem(
              icon: AppSvgs.changePass,
              title: 'Change Password',
              subtitle: 'Update your login password for security',
              trailing: Icon(Icons.chevron_right, color: AppColors.hintText),
              onTap: controller.onChangePassword,
            ),

            const SizedBox(height: 40),

            // Sign Out Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: controller.signOut,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: Colors.red.shade100),
                  backgroundColor: Colors.red.shade50,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppSvgs.signout,
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 10),
                    CustomTextView(
                      text: 'Sign Out',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.hintText.withOpacity(0.15), // Soft shadow using hintText color
              blurRadius: 10,
              offset: const Offset(0, 4), // Shadow below the card
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10), // Padding 10 on all sides
              decoration: BoxDecoration(
                color: Colors.white, // Background for the icon circle (adjust if needed)
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.hintText.withOpacity(0.15), // Same soft shadow color
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: SvgPicture.asset(
                icon,
                width: 28,
                height: 28,
                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextView(
                    text: title,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  const SizedBox(height: 4),
                  CustomTextView(
                    text: subtitle,
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}