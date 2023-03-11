import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/constants/constants.dart';
import 'package:linkedin/features/home/widgets/side_drawer.dart';
import 'package:linkedin/theme/pallete.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {},
          child: Container(
            width: MediaQuery.of(context).size.width * 0.65,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: Pallete.searchBarColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: const [
                SizedBox(
                  width: 6,
                ),
                Icon(
                  Icons.search,
                  color: Pallete.whiteColor,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  'Search',
                  style: TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.message_rounded),
          ),
        ],
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
          : null,
      drawer: const SideDrawer(),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Pallete.lightBackgroundColor,
        currentIndex: page,
        iconSize: 24,
        onTap: onPageChange,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              page == 0 ? CupertinoIcons.home : Icons.home_rounded,
              color: Pallete.whiteColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              page == 1 ? Icons.people_alt_rounded : Icons.people_sharp,
              color: Pallete.whiteColor,
            ),
            label: 'My Network',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box,
              color: Pallete.whiteColor,
            ),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              page == 3 ? Icons.notifications_rounded : Icons.notifications,
              color: Pallete.whiteColor,
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              page == 4 ? Icons.work_rounded : Icons.work_outline_rounded,
              color: Pallete.whiteColor,
            ),
            label: 'Jobs',
          ),
        ],
      ),
    );
  }
}
