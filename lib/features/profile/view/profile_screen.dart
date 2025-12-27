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
      body: Obx(() {
        final user = controller.user.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Profile Avatar
              if (user?.photoURL != null)
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(user!.photoURL!),
                )
              else
                CircleAvatar(
                  radius: 60,
                  child: Icon(Icons.person, size: 60),
                ),
              const SizedBox(height: 16),

              // Name
              if (user?.displayName != null)
                CustomTextView(
                  text: user!.displayName!,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),

              const SizedBox(height: 12),

              // Email
              if (user?.email != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email, size: 16, color: AppColors.hintText),
                    const SizedBox(width: 5),
                    CustomTextView(
                      text: user!.email!,
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),

              // Phone
              if (user?.phoneNumber != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, size: 16, color: AppColors.hintText),
                      const SizedBox(width: 5),
                      CustomTextView(
                        text: user!.phoneNumber!,
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 40),

              // Settings section remains unchanged...
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
        );
      }),
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