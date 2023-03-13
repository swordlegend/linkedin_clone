import 'package:flutter/material.dart';
import 'package:linkedin/core/enums/notification_type_enum.dart';
import 'package:linkedin/models/notification_model.dart' as model;
import 'package:linkedin/theme/pallete.dart';

class NotificationTile extends StatelessWidget {
  final model.Notification notification;
  const NotificationTile({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: notification.notificationType == NotificationType.like
          ? const Icon(
              Icons.thumb_up,
              color: Pallete.redColor,
            )
          : notification.notificationType == NotificationType.reshare
              ? const Icon(
                  Icons.repeat,
                  color: Pallete.lightBackgroundColor,
                )
              : null,
      title: Text(notification.text),
    );
  }
}
