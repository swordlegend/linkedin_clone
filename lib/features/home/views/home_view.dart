import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/constants/constants.dart';
import 'package:linkedin/features/home/widgets/side_drawer.dart';
import 'package:linkedin/features/jobs/widgets/create_job_view.dart';
import 'package:linkedin/features/search/views/search_view.dart';
import 'package:linkedin/theme/theme.dart';

class HomeView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeView(),
      );
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int page = 0;

  void onPageChange(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: UIConstants.appBar2(
        context: context,
        onSearchTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchView()),
          );
        },
        icon: Icons.message_rounded,
        onIconTap: () {},
        title: 'Search',
        col: theme.bottomNavigationBarTheme.selectedItemColor,
        bgColor: theme.appBarTheme.backgroundColor,
      ),
      body: IndexedStack(
        index: page,
        children: UIConstants.bottomTabBarPages,
      ),
      floatingActionButton: page == 1
          ? FloatingActionButton(
              onPressed: () {},
              child: const Icon(
                Icons.person_add_alt_1_rounded,
                color: Pallete.whiteColor,
                size: 28,
              ),
            )
          : page == 4
              ? FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => const CreateJobView());
                  },
                  child: const Icon(
                    Icons.add,
                    color: Pallete.whiteColor,
                    size: 28,
                  ),
                )
              : null,
      drawer: const SideDrawer(),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        currentIndex: page,
        iconSize: 24,
        onTap: onPageChange,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              page == 0 ? CupertinoIcons.home : Icons.home_rounded,
              color: theme.bottomNavigationBarTheme.selectedItemColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              page == 1 ? Icons.people_alt_rounded : Icons.people_sharp,
              color: theme.bottomNavigationBarTheme.selectedItemColor,
            ),
            label: 'My Network',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box,
              color: theme.bottomNavigationBarTheme.selectedItemColor,
            ),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              page == 3 ? Icons.notifications_rounded : Icons.notifications,
              color: theme.bottomNavigationBarTheme.selectedItemColor,
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              page == 4 ? Icons.work_rounded : Icons.work_outline_rounded,
              color: theme.bottomNavigationBarTheme.selectedItemColor,
            ),
            label: 'Jobs',
          ),
        ],
      ),
    );
  }
}
