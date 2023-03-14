import 'package:flutter/material.dart';
import 'package:linkedin/features/profile/views/profile_views.dart';
import 'package:linkedin/models/user_model.dart';
import 'package:linkedin/theme/theme.dart';

class SearchTile extends StatelessWidget {
  final UserModel userModel;
  const SearchTile({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          ProfileView.route(userModel.uid),
        );
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage(userModel.profilePic),
      ),
      title: Text(
        userModel.name,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userModel.bio,
            style: const TextStyle(
              color: Pallete.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
