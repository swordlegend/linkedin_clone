import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/models/post_model.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PostImageView extends ConsumerWidget {
  static route(PostModel postModel, List<String> imageLinks) {
    return MaterialPageRoute(
      builder: (context) => PostImageView(
        postModel: postModel,
        imageLinks: imageLinks,
      ),
    );
  }

  final PostModel postModel;
  final List<String> imageLinks;
  const PostImageView({
    super.key,
    required this.postModel,
    required this.imageLinks,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PhotoViewGallery.builder(
              itemCount: imageLinks.length,
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(imageLinks[index]),
                  // heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
