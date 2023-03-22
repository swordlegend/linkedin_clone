import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/common/common.dart';
import 'package:linkedin/features/auth/controllers/auth_controller.dart';
import 'package:linkedin/features/profile/views/profile_views.dart';
import 'package:linkedin/models/notification_model.dart' as model;

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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileView(
                    uid: data.uid,
                  ),
                ),
              );
            },
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
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.more_vert,
        ),
      ),
      title: Text(notification.text),
    );
  }
}
