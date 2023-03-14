import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linkedin/constants/constants.dart';
import 'package:linkedin/features/notification/view/notification_view.dart';
import 'package:linkedin/features/posts/views/post_view.dart';
import 'package:linkedin/features/posts/views/post_list.dart';
import 'package:linkedin/theme/theme.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.linkedinLogoFull,
        colorFilter: const ColorFilter.mode(
          Pallete.blueColor,
          BlendMode.srcIn,
        ),
        // color: Pallete.blueColor,
        height: 40,
        width: 160,
      ),
    );
  }

  static AppBar appBar2({
    required BuildContext context,
    required VoidCallback onSearchTap,
    required IconData icon,
    required VoidCallback onIconTap,
    required String title,
  }) {
    return AppBar(
      title: GestureDetector(
        onTap: onSearchTap,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.70,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Pallete.searchBarColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 6,
              ),
              const Icon(
                Icons.search,
                color: Pallete.whiteColor,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Pallete.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: onIconTap,
          icon: Icon(icon),
        ),
      ],
    );
  }

  static const List<Widget> bottomTabBarPages = [
    // Center(child: Text('Home')),
    // HomeView(),
    PostList(),
    Center(child: Text('My Network')),
    // NetworkView(),
    // Center(child: Text('Post')),
    PostView(),
    // Center(child: Text('Notifications')),
    NotificationView(),
    Center(child: Text('Jobs')),
    // JobsView(),
  ];
}
