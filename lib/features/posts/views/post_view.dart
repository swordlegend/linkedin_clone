import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/common/common.dart';
import 'package:linkedin/core/core.dart';
import 'package:linkedin/features/auth/controllers/auth_controller.dart';
import 'package:linkedin/features/home/views/home_view.dart';
import 'package:linkedin/features/posts/controllers/post_controllers.dart';
import 'package:linkedin/theme/theme.dart';

class PostView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const PostView(),
      );
  const PostView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostViewState();
}

class _PostViewState extends ConsumerState<PostView> {
  final postTextController = TextEditingController();
  List<File> images = [];

  @override
  void dispose() {
    super.dispose();
    postTextController.dispose();
    images.clear();
  }

  void sharePost() {
    ref.read(postControllerProvider.notifier).sharePost(
          images: images,
          text: postTextController.text,
          context: context,
          repliedTo: '',
          repliedToUserId: '',
        );
    Navigator.push(context, HomeView.route());
  }

  void onPickImages() async {
    images = await pickImages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailProvider);
    final isLoading = ref.watch(postControllerProvider);
    final theme = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, HomeView.route());
          },
          icon: const Icon(Icons.close, size: 30),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.clock)),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: RoundedSmallButton(
              onTap: sharePost,
              label: 'Post',
              backgroundColor: theme.brightness == Brightness.dark
                  ? Pallete.lightBlueColor
                  : Pallete.blueColor,
              // ignore: deprecated_member_use
              textColor: Pallete.whiteColor,
            ),
          ),
        ],
      ),
      // body: isLoading || currentUser == null
      body: isLoading
          ? const Loader()
          : currentUser.when(
              data: (data) {
                return data == null
                    ? const Loader()
                    : SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        data.profilePic,
                                      ),
                                      radius: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          data.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        'Everyone',
                                        style: TextStyle(
                                          color: Pallete.whiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                child: TextField(
                                  controller: postTextController,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: "What do you want to talk about?",
                                    hintStyle: TextStyle(
                                      color: Pallete.greyColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  maxLines: 4,
                                ),
                              ),
                              const SizedBox(height: 15),
                              if (images.isNotEmpty)
                                CarouselSlider(
                                  items: images.map(
                                    (file) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        child: Image.file(file),
                                      );
                                    },
                                  ).toList(),
                                  options: CarouselOptions(
                                    height: 400,
                                    enableInfiniteScroll: false,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
              },
              loading: () => const LoadingPage(),
              error: (error, stack) => ErrorPage(error: error.toString()),
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Pallete.greyColor,
              width: 0.3,
            ),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0).copyWith(
                left: 15,
                right: 15,
              ),
              child: GestureDetector(
                onTap: onPickImages,
                child: const Icon(Icons.camera_alt),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0).copyWith(
                left: 15,
                right: 15,
              ),
              child: const Icon(Icons.gif_box),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0).copyWith(
                left: 15,
                right: 15,
              ),
              child: const Icon(Icons.emoji_emotions),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0).copyWith(
                left: 15,
                right: 15,
              ),
              child: const Icon(Icons.more_horiz),
            ),
          ],
        ),
      ),
    );
  }
}
