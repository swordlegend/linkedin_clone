import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/common/common.dart';
import 'package:linkedin/constants/constants.dart';
import 'package:linkedin/features/auth/controllers/auth_controller.dart';
import 'package:linkedin/features/home/widgets/settings_view.dart';
import 'package:linkedin/features/search/views/search_view.dart';
import 'package:linkedin/theme/app_theme.dart';

class ProfileView extends ConsumerStatefulWidget {
  static route(String uid) => MaterialPageRoute(
        builder: (context) => ProfileView(
          uid: uid,
        ),
      );
  final String uid;
  const ProfileView({
    super.key,
    required this.uid,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailProvider).value;
    final user = ref.watch(userDetailsProvider(widget.uid));
    final theme = ref.watch(themeNotifierProvider);

    return currentUser == null
        ? const Loader()
        : user.when(
            data: (data) {
              return
                  // data == null ? const Loader() :
                  Scaffold(
                appBar: UIConstants.appBar2(
                  context: context,
                  onSearchTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchView(),
                      ),
                    );
                  },
                  icon: currentUser.uid == data.uid
                      ? Icons.settings
                      : Icons.more_vert,
                  onIconTap: currentUser.uid == data.uid
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsView(),
                            ),
                          );
                        }
                      : () {},
                  title: data.name,
                  col: theme.bottomNavigationBarTheme.selectedItemColor,
                  bgColor: theme.appBarTheme.backgroundColor,
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            // userModel.profilePic,
                            data.profilePic,
                            // : 'https://en.wikipedia.org/wiki/Image#/media/File:Image_created_with_a_mobile_phone.png',
                          ),
                        ),
                        Text(data.name),
                        Text(data.email),
                        if (currentUser.uid == data.uid) Text(data.uid),
                        if (currentUser.uid == data.uid)
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(authControllerProvider.notifier)
                                  .logout(context);
                            },
                            child: const Text('Sign Out'),
                          )
                      ],
                    ),
                  ),
                ),
              );
            },
            error: (error, stack) => ErrorPage(error: error.toString()),
            loading: () => const Loader(),
          );
  }
}
