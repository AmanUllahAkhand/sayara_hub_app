import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_svgs.dart';
import '../../../core/widgets/custom_text_view.dart';
import '../controller/notification_controller.dart';
import '../model/notification_model.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: CustomTextView(
          text: 'Notification',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return const Center(child: Text('No notifications yet'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final noti = controller.notifications[index];
            return _buildNotificationItem(noti);
          },
        );
      }),
    );
  }

  Widget _buildNotificationItem(NotificationItem noti) {
    return Dismissible(
      key: Key(noti.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: SvgPicture.asset(
          AppSvgs.delete,
        ),
      ),

      onDismissed: (direction) {
        controller.deleteNotification(noti.id);
        Get.snackbar('Deleted', 'Notification removed', backgroundColor: Colors.red.withOpacity(0.8), colorText: Colors.white);
      },
      confirmDismiss: (direction) async {
        controller.showDeleteConfirm(noti.id, noti.title);
        return false;
      },
      child: GestureDetector(
        onTap: () => controller.markAsRead(noti.id),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: noti.isRead ? Colors.white : Colors.blue.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue.shade200.withOpacity(0.5)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon with background



              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          _getIcon(noti.type),
                          width: 28,
                          height: 28,
                        ),
                        SizedBox(width: 10,),
                        CustomTextView(
                          text: noti.title,
                          fontWeight: noti.isRead ? FontWeight.w500 : FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.textPrimary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    CustomTextView(
                      text: noti.message,
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(height: 8),
                    CustomTextView(
                      text: noti.timeAgo,
                      fontSize: 12,
                      color: AppColors.hintText,
                    ),
                  ],
                ),
              ),

              // Unread indicator dot (only if unread)
              if (!noti.isRead)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.booking:
        return AppSvgs.booking;
      case NotificationType.reminder:
        return AppSvgs.reminder;
      case NotificationType.feature:
        return AppSvgs.newFeature;
    }
  }

  Color _getIconBgColor(NotificationType type) {
    switch (type) {
      case NotificationType.booking:
        return Colors.blue.shade100;
      case NotificationType.reminder:
        return Colors.green.shade100;
      case NotificationType.feature:
        return Colors.purple.shade100;
    }
  }

}