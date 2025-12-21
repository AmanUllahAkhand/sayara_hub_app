import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_text_view.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  final RxList<NotificationItem> notifications = <NotificationItem>[
    NotificationItem(
      id: '1',
      title: 'Bookings Alerts',
      message: 'Good news! Anil Kumar just booked your Convo.',
      timeAgo: '2h ago',
      isRead: false,
      type: NotificationType.booking,
    ),
    NotificationItem(
      id: '2',
      title: 'Reminder',
      message: 'Tomorrow is your Convo!',
      timeAgo: '5h ago',
      isRead: true,
      type: NotificationType.reminder,
    ),
    NotificationItem(
      id: '3',
      title: 'New Feature Alert',
      message: 'A new version of the app is available!',
      timeAgo: '5h ago',
      isRead: false,
      type: NotificationType.feature,
    ),
  ].obs;

  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      notifications[index] = notifications[index].copyWith(isRead: true);
      notifications.refresh();
    }
  }

  void deleteNotification(String id) {
    notifications.removeWhere((n) => n.id == id);
    notifications.refresh();
  }

  void showDeleteConfirm(String id, String title) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: CustomTextView(
          text: 'Delete Notification?',
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        content: CustomTextView(
          text: 'Are you sure you want to delete "$title"?',
          color: AppColors.textSecondary,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: CustomTextView(text: 'No', color: AppColors.primary),
          ),
          TextButton(
            onPressed: () {
              deleteNotification(id);
              Get.back();
            },
            child: CustomTextView(text: 'Yes', color: Colors.red),
          ),
        ],
      ),
    );
  }
}

// Extension for easy copy
extension NotificationCopy on NotificationItem {
  NotificationItem copyWith({bool? isRead}) {
    return NotificationItem(
      id: id,
      title: title,
      message: message,
      timeAgo: timeAgo,
      isRead: isRead ?? this.isRead,
      type: type,
    );
  }
}