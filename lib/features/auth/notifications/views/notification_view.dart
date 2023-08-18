import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/loading_page.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/notifications/notification_controller.dart';
import 'package:twitter_clone/features/auth/notifications/widget/notification_tile.dart';
import 'package:twitter_clone/models/notification_model.dart' as model;
import '../../../../common/error_page.dart';
import '../../../../constants/appwrite_constants.dart';

class NotificationView extends ConsumerWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: currentUser == null
          ? const Loader()
          : ref.watch(getNotificationsProvider(currentUser.uid)).when(
              data: (notifications) {
                return ref.watch(getLatestNotificationProvider).when(
                    data: (data) {
                      if (data.events.contains(
                        'databases.*.collections.${AppwriteConstants.notificationsCollection}.documents.*.create',
                      )) {
                        final latestNotification =
                            model.Notification.fromMap(data.payload);
                        if (latestNotification.uid == currentUser.uid) {
                          notifications.insert(0, latestNotification);
                        }
                        notifications.insert(
                            0, model.Notification.fromMap(data.payload));
                      }

                      return ListView.builder(
                          itemCount: notifications.length,
                          itemBuilder: (BuildContext context, int index) {
                            final notification = notifications[index];
                            return NotificationTile(notification: notification);
                            ;
                          });
                    },
                    error: ((error, stackTrace) =>
                        ErrorText(error: error.toString())),
                    loading: () {
                      return ListView.builder(
                          itemCount: notifications.length,
                          itemBuilder: (BuildContext context, int index) {
                            final notification = notifications[index];
                            return NotificationTile(notification: notification);
                          });
                    });
              },
              error: ((error, stackTrace) =>
                  ErrorText(error: error.toString())),
              loading: () => const Loader()),
    );
  }
}
