// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/common/common.dart';
import 'package:linkedin/features/auth/controllers/auth_controller.dart';
import 'package:linkedin/features/home/widgets/settings_view.dart';
import 'package:linkedin/features/profile/views/profile_views.dart';
import 'package:linkedin/theme/theme.dart';

class SideDrawer extends ConsumerWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailProvider);
    final theme = ref.watch(themeNotifierProvider);

    return SafeArea(
      child: Drawer(
        child: currentUser.when(
          data: (data) {
            return data == null
                ? const Loader()
                : Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                ProfileView.route(data.uid),
                              );
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(data.profilePic),
                              radius: 28.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            data.name,
                            style: TextStyle(
                              color: theme.textTheme.bodyText1!.color!,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              'View Profile',
                              style: TextStyle(
                                color: ref
                                            .watch(
                                                themeNotifierProvider.notifier)
                                            .mode ==
                                        ThemeMode.dark
                                    ? Pallete.whiteColor.withOpacity(0.7)
                                    : Pallete.blackColor.withOpacity(0.7),
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '65 profile views',
                            style: TextStyle(
                              color: ref
                                          .watch(themeNotifierProvider.notifier)
                                          .mode ==
                                      ThemeMode.dark
                                  ? Pallete.whiteColor.withOpacity(0.7)
                                  : Pallete.blackColor.withOpacity(0.7),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Divider(
                        color: ref.watch(themeNotifierProvider.notifier).mode ==
                                ThemeMode.dark
                            ? Pallete.whiteColor
                            : Pallete.blackColor,
                        thickness: 0.5,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Groups',
                              style: TextStyle(
                                color: theme.textTheme.bodyText2!.color!,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.018,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Events',
                              style: TextStyle(
                                color: theme.textTheme.bodyText2!.color!,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.47,
                      ),
                      Divider(
                        color: ref.watch(themeNotifierProvider.notifier).mode ==
                                ThemeMode.dark
                            ? Pallete.whiteColor
                            : Pallete.blackColor,
                        thickness: 0.5,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                SettingsView.route(),
                              );
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.settings,
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  'Settings',
                                  style: TextStyle(
                                    color: theme.textTheme.bodyText2!.color!,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          },
          loading: () => const Center(child: Loader()),
          error: (error, stack) => ErrorPage(error: error.toString()),
        ),
      ),
    );
  }
}
