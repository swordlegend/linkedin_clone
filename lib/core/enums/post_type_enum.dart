enum PostType {
  text('text'),
  image('image'),
  jobs('jobs');

  final String type;
  const PostType(this.type);
}

extension ConvertTweet on String {
  PostType toPostTypeEnum() {
    switch (this) {
      case 'text':
        return PostType.text;
      case 'image':
        return PostType.image;
      case 'jobs':
        return PostType.jobs;
      default:
        return PostType.text;
    }
  }
}