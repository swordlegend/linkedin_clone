import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:linkedin/common/common.dart';
import 'package:linkedin/core/enums/post_type_enum.dart';
import 'package:linkedin/features/auth/controllers/auth_controller.dart';
import 'package:linkedin/features/posts/controllers/post_controllers.dart';
import 'package:linkedin/features/posts/views/post_image_view.dart';
import 'package:linkedin/features/posts/widgets/carousel_image.dart';
import 'package:linkedin/features/posts/widgets/hashtag_text.dart';
import 'package:linkedin/features/profile/views/profile_views.dart';
import 'package:linkedin/models/post_model.dart';
import 'package:linkedin/theme/theme.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCard extends ConsumerWidget {
  final PostModel postModel;
  const PostCard({
    super.key,
    required this.postModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserDetailProvider).when(
          data: (currentUser) {
            return currentUser == null
                ? const SizedBox.shrink()
                : ref.watch(userDetailsProvider(postModel.uid)).when(
                      data: (user) {
                        // ignore: unnecessary_null_comparison
                        return user == null
                            ? const SizedBox.shrink()
                            : GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   PostReplyScreen.route(tweet),
                                  // );
                                },
                                child: Column(
                                  children: [
                                    if (postModel.resharedBy.isNotEmpty) ...[
                                      Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(10),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  ProfileView.route(
                                                    postModel.resharedByUid,
                                                  ),
                                                );
                                              },
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  postModel.resharedProfilePic,
                                                ),
                                                radius: 24,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      right: 1,
                                                    ),
                                                    child: Text(
                                                      postModel.resharedBy,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 8.0,
                                                    ),
                                                    child: Text(
                                                      '1st',
                                                      style: TextStyle(
                                                        color:
                                                            Pallete.greyColor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (user.bio.isNotEmpty)
                                                Text(
                                                  user.bio,
                                                  style: const TextStyle(
                                                    color: Pallete.greyColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              Row(
                                                children: [
                                                  Text(
                                                    timeago.format(
                                                      postModel.postedAt,
                                                      locale: 'en_short',
                                                    ),
                                                    style: const TextStyle(
                                                      color: Pallete.greyColor,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  const Icon(
                                                    Icons.public,
                                                    color: Pallete.greyColor,
                                                    size: 14,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              if (postModel.resharedByUid ==
                                                  currentUser.uid) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: const Text(
                                                      'Delete Post',
                                                    ),
                                                    content: const Text(
                                                      'Are you sure you want to delete this post?',
                                                    ),
                                                    backgroundColor:
                                                        Pallete.backgroundColor,
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                            context,
                                                          );
                                                        },
                                                        child: const Text(
                                                          'Cancel',
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                            context,
                                                          );
                                                          ref
                                                              .watch(
                                                                postControllerProvider
                                                                    .notifier,
                                                              )
                                                              .deletePost(
                                                                postModel,
                                                                context,
                                                              );
                                                        },
                                                        child: const Text(
                                                          'Delete',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.more_vert,
                                              color: Pallete.greyColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Pallete.greyColor
                                                  .withOpacity(0.2),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                      10,
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          ProfileView.route(
                                                            user.uid,
                                                          ),
                                                        );
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                          user.profilePic,
                                                        ),
                                                        radius: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                              right: 1,
                                                            ),
                                                            child: Text(
                                                              user.name,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 8.0,
                                                            ),
                                                            child: Text(
                                                              '1st',
                                                              style: TextStyle(
                                                                color: Pallete
                                                                    .greyColor,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      if (user.bio.isNotEmpty)
                                                        Text(
                                                          user.bio,
                                                          style:
                                                              const TextStyle(
                                                            color: Pallete
                                                                .greyColor,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 8.0,
                                                          ),
                                                          child: HashtagText(
                                                            text:
                                                                postModel.text,
                                                          ),
                                                        ),
                                                        if (postModel
                                                                .postType ==
                                                            PostType.image)
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                PostImageView
                                                                    .route(
                                                                  postModel,
                                                                  postModel
                                                                      .imageLinks,
                                                                ),
                                                              );
                                                            },
                                                            child:
                                                                CarouselImage(
                                                              imageLinks:
                                                                  postModel
                                                                      .imageLinks,
                                                            ),
                                                          ),
                                                        if (postModel.link
                                                            .isNotEmpty) ...[
                                                          const SizedBox(
                                                              height: 4),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              right: 6.0,
                                                            ),
                                                            child:
                                                                AnyLinkPreview(
                                                              cache:
                                                                  const Duration(
                                                                seconds: 8,
                                                              ),
                                                              displayDirection:
                                                                  UIDirection
                                                                      .uiDirectionHorizontal,
                                                              link: postModel
                                                                  .link,
                                                            ),
                                                          ),
                                                        ],
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        color: Pallete.greyColor,
                                        thickness: 0.2,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            LikeButton(
                                              size: 18,
                                              isLiked: postModel.likes
                                                  .contains(currentUser.uid),
                                              likeBuilder: (bool isLiked) {
                                                return Icon(
                                                  CupertinoIcons.hand_thumbsup,
                                                  color: isLiked
                                                      ? Pallete.redColor
                                                      : Pallete.greyColor,
                                                  size: 18,
                                                  semanticLabel: 'Like',
                                                );
                                              },
                                              likeCount: postModel.likes.length,
                                              countBuilder: (
                                                int? count,
                                                bool isLiked,
                                                String text,
                                              ) {
                                                var color = isLiked
                                                    ? Pallete.redColor
                                                    : Pallete.greyColor;
                                                Text(
                                                  text,
                                                  style: TextStyle(
                                                    color: color,
                                                    fontSize: 14,
                                                  ),
                                                );
                                                return null;
                                              },
                                              onTap: (bool isLiked) async {
                                                ref
                                                    .watch(
                                                      postControllerProvider
                                                          .notifier,
                                                    )
                                                    .likePost(
                                                      postModel,
                                                      currentUser,
                                                    );
                                                return !isLiked;
                                              },
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                CupertinoIcons.chat_bubble_text,
                                                color: Pallete.greyColor,
                                                size: 18,
                                                semanticLabel: 'Comment',
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                ref
                                                    .watch(
                                                      postControllerProvider
                                                          .notifier,
                                                    )
                                                    .resharePost(
                                                      postModel,
                                                      currentUser,
                                                      context,
                                                    );
                                              },
                                              icon: const Icon(
                                                FontAwesomeIcons.retweet,
                                                color: Pallete.greyColor,
                                                size: 18,
                                                semanticLabel: 'Repost',
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                CupertinoIcons.share_up,
                                                color: Pallete.greyColor,
                                                size: 18,
                                                semanticLabel: 'Share',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                    if (postModel.resharedBy.isEmpty) ...[
                                      Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(10),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  ProfileView.route(user.uid),
                                                );
                                              },
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  user.profilePic,
                                                ),
                                                radius: 24,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      right: 1,
                                                    ),
                                                    child: Text(
                                                      user.name,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 8.0,
                                                    ),
                                                    child: Text(
                                                      '1st',
                                                      style: TextStyle(
                                                        color:
                                                            Pallete.greyColor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (user.bio.isNotEmpty)
                                                Text(
                                                  user.bio,
                                                  style: const TextStyle(
                                                    color: Pallete.greyColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              Row(
                                                children: [
                                                  Text(
                                                    timeago.format(
                                                      postModel.postedAt,
                                                      locale: 'en_short',
                                                    ),
                                                    style: const TextStyle(
                                                      color: Pallete.greyColor,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  const Icon(
                                                    Icons.public,
                                                    color: Pallete.greyColor,
                                                    size: 14,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              if (postModel.uid ==
                                                  currentUser.uid) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: const Text(
                                                      'Delete Post',
                                                    ),
                                                    content: const Text(
                                                      'Are you sure you want to delete this post?',
                                                    ),
                                                    backgroundColor:
                                                        Pallete.backgroundColor,
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                            context,
                                                          );
                                                        },
                                                        child: const Text(
                                                          'Cancel',
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                            context,
                                                          );
                                                          ref
                                                              .watch(
                                                                postControllerProvider
                                                                    .notifier,
                                                              )
                                                              .deletePost(
                                                                postModel,
                                                                context,
                                                              );
                                                        },
                                                        child: const Text(
                                                          'Delete',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.more_vert,
                                              color: Pallete.greyColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: HashtagText(
                                                    text: postModel.text,
                                                  ),
                                                ),
                                                if (postModel.postType ==
                                                    PostType.image)
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        PostImageView.route(
                                                          postModel,
                                                          postModel.imageLinks,
                                                        ),
                                                      );
                                                    },
                                                    child: CarouselImage(
                                                      imageLinks:
                                                          postModel.imageLinks,
                                                    ),
                                                  ),
                                                if (postModel
                                                    .link.isNotEmpty) ...[
                                                  const SizedBox(height: 4),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 6.0,
                                                    ),
                                                    child: AnyLinkPreview(
                                                      cache: const Duration(
                                                        seconds: 8,
                                                      ),
                                                      displayDirection: UIDirection
                                                          .uiDirectionHorizontal,
                                                      link: postModel.link,
                                                    ),
                                                  ),
                                                ],
                                                const Divider(
                                                  color: Pallete.greyColor,
                                                  thickness: 0.2,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8.0,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      LikeButton(
                                                        size: 18,
                                                        isLiked: postModel.likes
                                                            .contains(
                                                          currentUser.uid,
                                                        ),
                                                        likeBuilder:
                                                            (bool isLiked) {
                                                          return Icon(
                                                            CupertinoIcons
                                                                .hand_thumbsup,
                                                            color: isLiked
                                                                ? Pallete
                                                                    .redColor
                                                                : Pallete
                                                                    .greyColor,
                                                            size: 18,
                                                            semanticLabel:
                                                                'Like',
                                                          );
                                                        },
                                                        likeCount: postModel
                                                            .likes.length,
                                                        countBuilder: (
                                                          int? count,
                                                          bool isLiked,
                                                          String text,
                                                        ) {
                                                          var color = isLiked
                                                              ? Pallete.redColor
                                                              : Pallete
                                                                  .greyColor;
                                                          Text(
                                                            text,
                                                            style: TextStyle(
                                                              color: color,
                                                              fontSize: 14,
                                                            ),
                                                          );
                                                          return null;
                                                        },
                                                        onTap: (bool
                                                            isLiked) async {
                                                          ref
                                                              .watch(
                                                                postControllerProvider
                                                                    .notifier,
                                                              )
                                                              .likePost(
                                                                postModel,
                                                                currentUser,
                                                              );
                                                          return !isLiked;
                                                        },
                                                      ),
                                                      IconButton(
                                                        onPressed: () {},
                                                        icon: const Icon(
                                                          CupertinoIcons
                                                              .chat_bubble_text,
                                                          color:
                                                              Pallete.greyColor,
                                                          size: 18,
                                                          semanticLabel:
                                                              'Comment',
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          ref
                                                              .watch(
                                                                postControllerProvider
                                                                    .notifier,
                                                              )
                                                              .resharePost(
                                                                postModel,
                                                                currentUser,
                                                                context,
                                                              );
                                                        },
                                                        icon: const Icon(
                                                          FontAwesomeIcons
                                                              .retweet,
                                                          color:
                                                              Pallete.greyColor,
                                                          size: 18,
                                                          semanticLabel:
                                                              'Repost',
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {},
                                                        icon: const Icon(
                                                          CupertinoIcons
                                                              .share_up,
                                                          color:
                                                              Pallete.greyColor,
                                                          size: 18,
                                                          semanticLabel:
                                                              'Share',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                    const Divider(
                                      color: Pallete.greyColor,
                                      thickness: 0.2,
                                    ),
                                  ],
                                ),
                              );
                      },
                      error: (error, stackTrace) => ErrorText(
                        error: error.toString(),
                      ),
                      loading: () => const SizedBox.shrink(),
                    );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const SizedBox.shrink(),
        );
  }
}
