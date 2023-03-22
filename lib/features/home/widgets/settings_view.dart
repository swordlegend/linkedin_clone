import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/common/common.dart';
import 'package:linkedin/features/auth/controllers/auth_controller.dart';
import 'package:linkedin/theme/theme.dart';

class SettingsView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SettingsView(),
      );
  const SettingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  void toggleTheme(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailProvider);
    final theme = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          // ignore: deprecated_member_use
          style: TextStyle(color: theme.textTheme.bodyText2!.color!),
        ),
        centerTitle: true,
      ),
      body: currentUser.when(
        data: (data) {
          return data == null
              ? const Center(child: Loader())
              : Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            data.profilePic,
                            // : 'https://en.wikipedia.org/wiki/Image#/media/File:Image_created_with_a_mobile_phone.png',
                          ),
                        ),
                        Text(data.name),
                        Text(data.email),
                        Text(data.uid),
                        TextButton(
                          onPressed: () {
                            ref
                                .read(authControllerProvider.notifier)
                                .logout(context);
                          },
                          child: const Text('Sign Out'),
                        ),
                        CupertinoSwitch(
                          value:
                              ref.watch(themeNotifierProvider.notifier).mode ==
                                  ThemeMode.dark,
                          onChanged: (val) => toggleTheme(ref),
                        ),
                      ],
                    ),
                  ),
                );
        },
        error: (error, stack) => ErrorPage(error: error.toString()),
        loading: () => const LoadingPage(),
      ),
    );
  }
}
