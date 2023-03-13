import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/common/common.dart';
import 'package:linkedin/constants/constants.dart';
import 'package:linkedin/features/auth/controllers/auth_controller.dart';
import 'package:linkedin/features/notification/controller/notification_controller.dart';
import 'package:linkedin/features/notification/widgets/notification_tile.dart';
import 'package:linkedin/models/notification_model.dart' as model;

class NotificationView extends ConsumerWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserDetailProvider).when(
          data: (currentUser) {
            return currentUser == null
                ? const Loader()
                : ref.watch(getNotificationsProvider(currentUser.uid)).when(
                      data: (notifications) {
                        return ref.watch(getLatestNotificationProvider).when(
                              data: (data) {
                                if (data.events.contains(
                                  'databases.*.collections.${AppwriteConstants.notificationsCollection}.documents.*.create',
                                )) {
                                  final latestNotif =
                                      model.Notification.fromMap(data.payload);
                                  if (latestNotif.uid == currentUser.uid) {
                                    notifications.insert(0, latestNotif);
                                  }
                                }

                                return ListView.builder(
                                  itemCount: notifications.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final notification = notifications[index];
                                    return NotificationTile(
                                      notification: notification,
                                    );
                                  },
                                );
                              },
                              error: (error, stackTrace) => ErrorText(
                                error: error.toString(),
                              ),
                              loading: () {
                                return ListView.builder(
                                  itemCount: notifications.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final notification = notifications[index];
                                    return NotificationTile(
                                      notification: notification,
                                    );
                                  },
                                );
                              },
                            );
                      },
                      error: (error, stackTrace) => ErrorText(
                        error: error.toString(),
                      ),
                      loading: () => const Loader(),
                    );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
