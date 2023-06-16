import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/common/common.dart';
import 'package:linkedin/constants/constants.dart';
import 'package:linkedin/features/auth/controllers/auth_controller.dart';
import 'package:linkedin/features/home/widgets/settings_view.dart';
import 'package:linkedin/features/search/views/search_view.dart';
import 'package:linkedin/theme/app_theme.dart';
import 'package:linkedin/theme/pallete.dart';

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
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 90,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  data.bannerPic,
                                ),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                margin: const EdgeInsets.only(
                                  top: 50,
                                  left: 10,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: theme.brightness == Brightness.light
                                        ? Pallete.whiteColor
                                        : Pallete.blackColor,
                                    width: 3,
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      data.profilePic,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              if (currentUser.uid == data.uid) ...[
                                Positioned(
                                  top: 120,
                                  left: 86,
                                  child: Container(
                                    height: 23,
                                    width: 23,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Pallete.blueColor,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            if (currentUser.uid == data.uid) ...[
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Text(
                          data.bio,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Text(
                          'Delloite',
                          // data.companyName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Text(
                          'Delhi, India',
                          // data.location,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '500+',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              'connections',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Contact info',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RoundedSmallButton(
                              onTap: () {},
                              label: currentUser.uid == data.uid
                                  ? 'Open to'
                                  : 'Connect',
                            ),
                            RoundedSmallButton(
                              onTap: () {},
                              backgroundColor:
                                  theme.brightness == Brightness.dark
                                      ? Pallete.darkBackgroundColor
                                      : Pallete.whiteColor,
                              label: currentUser.uid == data.uid
                                  ? 'Add section'
                                  : 'Message',
                              textColor: theme.brightness == Brightness.dark
                                  ? Pallete.whiteColor
                                  : Pallete.blackColor,
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return currentUser.uid == data.uid
                                        ? AlertDialog(
                                            title: const Text('Logout'),
                                            content: const Text(
                                              'Are you sure you want to logout ?',
                                            ),
                                            backgroundColor: theme
                                                .appBarTheme.backgroundColor,
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  ref
                                                      .read(
                                                          authControllerProvider
                                                              .notifier)
                                                      .logout(context);
                                                },
                                                child: const Text('Logout'),
                                              ),
                                            ],
                                          )
                                        : AlertDialog(
                                            title: Text('Report ${data.name}'),
                                            content: Text(
                                              'Are you sure you want to report ${data.name} ?',
                                            ),
                                            backgroundColor: theme
                                                .appBarTheme.backgroundColor,
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Report'),
                                              ),
                                            ],
                                          );
                                  },
                                );
                              },
                              icon: const Icon(Icons.more_horiz),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'About',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            if (currentUser.uid == data.uid) ...[
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          data.bio,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Activity',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'See all',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Experience',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            if (currentUser.uid == data.uid) ...[
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      //         ListView.builder(
                      //           shrinkWrap: true,
                      //           physics: const NeverScrollableScrollPhysics(),
                      //           itemCount: data.experience.length,
                      //           itemBuilder: (context, index) {
                      //             return Padding(
                      //               padding: const EdgeInsets.symmetric(
                      //                 horizontal: 10,
                      //               ),
                      //               child: Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(
                      //                     data.experience[index].title,
                      //                     style: Theme.of(context).textTheme.headline6,
                      //                   ),
                      //                   Text(
                      //                     data.experience[index].company,
                      //                     style: Theme.of(context).textTheme.subtitle1,
                      //                   ),
                      //       ],
                      //     ),
                      //   );
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Education',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            if (currentUser.uid == data.uid) ...[
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Projects',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            if (currentUser.uid == data.uid) ...[
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Skills',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            if (currentUser.uid == data.uid) ...[
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (error, stack) => ErrorPage(error: error.toString()),
            loading: () => const Loader(),
          );
  }
}
