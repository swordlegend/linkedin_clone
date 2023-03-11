import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linkedin/constants/constants.dart';
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

  static const List<Widget> bottomTabBarPages = [
    // Center(child: Text('Home')),
    // HomeView(),
    PostList(),
    Center(child: Text('My Network')),
    // NetworkView(),
    // Center(child: Text('Post')),
    PostView(),
    Center(child: Text('Notifications')),
    // NotificationView(),
    Center(child: Text('Jobs')),
    // JobsView(),
  ];
}
