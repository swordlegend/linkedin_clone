import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/apis/post_api.dart';
import 'package:linkedin/apis/storage_api.dart';
import 'package:linkedin/core/core.dart';
import 'package:linkedin/core/enums/post_type_enum.dart';
import 'package:linkedin/features/auth/controllers/auth_controller.dart';
import 'package:linkedin/models/post_model.dart';
import 'package:linkedin/models/user_model.dart';

final postControllerProvider = StateNotifierProvider<PostController, bool>(
  (ref) {
    return PostController(
      ref: ref,
      postAPI: ref.watch(postApiProvider),
      storageAPI: ref.watch(storageAPIProvider),
    );
  },
);

final getPostsProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(postControllerProvider.notifier).getPosts();
});

final getRepliesToPostProvider =
    FutureProvider.family.autoDispose((ref, PostModel postModel) {
  return ref.watch(postControllerProvider.notifier).getRepliesToPost(postModel);
});

final getLatestPostProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(postApiProvider).getLatestPost();
});

final getPostByIdProvider = FutureProvider.family.autoDispose((ref, String id) {
  return ref.watch(postControllerProvider.notifier).getPostById(id);
});

final getPostByHashtagProvider =
    FutureProvider.family.autoDispose((ref, String hashtag) {
  return ref.watch(postControllerProvider.notifier).getPostsByHashtag(hashtag);
});

class PostController extends StateNotifier<bool> {
  final PostApi _postAPI;
  final StorageAPI _storageAPI;
  final Ref _ref;
  PostController({
    required Ref ref,
    required PostApi postAPI,
    required StorageAPI storageAPI,
  })  : _ref = ref,
        _postAPI = postAPI,
        _storageAPI = storageAPI,
        super(false);

  Future<List<PostModel>> getPosts() async {
    Future.delayed(const Duration(seconds: 2));
    final posts = await _postAPI.getPosts();
    return posts.map((posts) => PostModel.fromMap(posts.data)).toList();
  }

  Future<PostModel> getPostById(String id) async {
    Future.delayed(const Duration(seconds: 2));
    final post = await _postAPI.getPostById(id);
    return PostModel.fromMap(post.data);
  }

  void likePost(PostModel postModel, UserModel user) async {
    List<String> likes = postModel.likes;

    if (postModel.likes.contains(user.uid)) {
      likes.remove(user.uid);
    } else {
      likes.add(user.uid);
    }

    postModel = postModel.copyWith(likes: likes);
    final res = await _postAPI.likePost(postModel);
    res.fold((l) => null, (r) => null);
  }

  void deletePost(
    PostModel postModel,
    BuildContext context,
  ) async {
    final res = await _postAPI.deletePost(postModel);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => showSnackBar(context, 'Post deleted!'),
    );
  }

  void resharePost(
    PostModel postModel,
    UserModel currentUser,
    BuildContext context,
  ) async {
    postModel = postModel.copyWith(
      resharedBy: currentUser.name,
      resharedProfilePic: currentUser.profilePic,
      likes: [],
      commentIds: [],
      reshareCount: postModel.reshareCount + 1,
    );

    final res = await _postAPI.updateReshareCount(postModel);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) async {
        postModel = postModel.copyWith(
          id: ID.unique(),
          reshareCount: postModel.reshareCount,
          postedAt: DateTime.now(),
        );
        final res2 = await _postAPI.sharePost(postModel);
        res2.fold(
          (l) => showSnackBar(context, l.message),
          (r) => showSnackBar(context, 'Reshared!'),
        );
      },
    );
  }

  void sharePost({
    required List<File> images,
    required String text,
    required BuildContext context,
    required String repliedTo,
    required String repliedToUserId,
  }) {
    if (text.isEmpty) {
      showSnackBar(context, 'Please enter text');
      return;
    }

    if (images.isNotEmpty) {
      Future.delayed(const Duration(seconds: 5));
      _shareImagePost(
        images: images,
        text: text,
        context: context,
        repliedTo: repliedTo,
        repliedToUserId: repliedToUserId,
      );
    } else {
      _shareTextPost(
        text: text,
        context: context,
        repliedTo: repliedTo,
        repliedToUserId: repliedToUserId,
      );
    }
  }

  Future<List<PostModel>> getRepliesToPost(PostModel postModel) async {
    Future.delayed(const Duration(seconds: 2));
    final documents = await _postAPI.getRepliesToPost(postModel);
    return documents.map((post) => PostModel.fromMap(post.data)).toList();
  }

  Future<List<PostModel>> getPostsByHashtag(String hashtag) async {
    Future.delayed(const Duration(seconds: 2));
    final documents = await _postAPI.getPostsByHashtag(hashtag);
    return documents.map((post) => PostModel.fromMap(post.data)).toList();
  }

  void _shareImagePost({
    required List<File> images,
    required String text,
    required BuildContext context,
    required String repliedTo,
    required String repliedToUserId,
  }) async {
    state = true;
    final hashtags = _getHashtagsFromText(text);
    String link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailProvider).value!;
    final imageLinks = await _storageAPI.uploadImage(images);
    PostModel postModel = PostModel(
      text: text,
      hashtags: hashtags,
      link: link,
      imageLinks: imageLinks,
      uid: user.uid,
      userProfilePic: user.profilePic,
      resharedProfilePic: '',
      postType: PostType.image,
      postedAt: DateTime.now(),
      likes: const [],
      commentIds: const [],
      id: '',
      reshareCount: 0,
      resharedBy: '',
      repliedTo: repliedTo,
    );
    final res = await _postAPI.sharePost(postModel);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => showSnackBar(context, 'posted successfully'),
    );
    state = false;
  }

  void _shareTextPost({
    required String text,
    required BuildContext context,
    required String repliedTo,
    required String repliedToUserId,
  }) async {
    state = true;
    final hashtags = _getHashtagsFromText(text);
    String link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailProvider).value!;
    PostModel postModel = PostModel(
      text: text,
      hashtags: hashtags,
      link: link,
      imageLinks: const [],
      uid: user.uid,
      userProfilePic: user.profilePic,
      resharedProfilePic: '',
      postType: PostType.text,
      postedAt: DateTime.now(),
      likes: const [],
      commentIds: const [],
      id: '',
      reshareCount: 0,
      resharedBy: '',
      repliedTo: repliedTo,
    );
    final res = await _postAPI.sharePost(postModel);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => showSnackBar(context, 'posted successfully'),
    );
    state = false;
  }

  String _getLinkFromText(String text) {
    String link = '';
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith('https://') || word.startsWith('www.')) {
        link = word;
      }
    }
    return link;
  }

  List<String> _getHashtagsFromText(String text) {
    List<String> hashtags = [];
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith('#')) {
        hashtags.add(word);
      }
    }
    return hashtags;
  }
}
