import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/common/common.dart';
import 'package:linkedin/features/auth/controllers/auth_controller.dart';

class ProfileView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ProfileView(),
      );
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        centerTitle: true,
      ),
      body: currentUser.when(
        data: (data) {
          return Center(
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
                      ref.read(authControllerProvider.notifier).logout(context);
                    },
                    child: const Text('Sign Out'),
                  )
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