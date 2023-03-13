import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/common/common.dart';
import 'package:linkedin/features/auth/controllers/auth_controller.dart';
import 'package:linkedin/models/notification_model.dart' as model;
import 'package:linkedin/theme/pallete.dart';

class NotificationTile extends ConsumerWidget {
  final model.Notification notification;
  const NotificationTile({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityUser = ref.watch(userDetailsProvider(notification.uid));

    return ListTile(
      leading: activityUser.when(
        data: (data) {
          return GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              backgroundImage: NetworkImage(data.profilePic),
              radius: 22,
            ),
          );
        },
        error: (error, stackTrace) => ErrorText(
          error: error.toString(),
        ),
        loading: () => const Loader(),
      ),
      trailing: const Icon(
        Icons.more_vert,
        color: Pallete.greyColor,
      ),
      title: Text(notification.text),
    );
  }
}
