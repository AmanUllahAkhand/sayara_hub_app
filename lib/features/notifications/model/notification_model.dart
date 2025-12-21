class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String timeAgo;
  final bool isRead;
  final NotificationType type; // To differentiate icon & style

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.isRead,
    required this.type,
  });
}

enum NotificationType {
  booking,
  reminder,
  feature,
}