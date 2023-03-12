import 'package:flutter/foundation.dart';
import 'package:linkedin/core/enums/post_type_enum.dart';

@immutable
class PostModel {
  final String text;
  final List<String> hashtags;
  final String link;
  final List<String> imageLinks;
  final String uid;
  final String userProfilePic;
  final String resharedProfilePic;
  final String resharedByUid;
  final PostType postType;
  final DateTime postedAt;
  final List<String> likes;
  final List<String> commentIds;
  final String id;
  final int reshareCount;
  final String resharedBy;
  final String repliedTo;
  const PostModel({
    required this.text,
    required this.hashtags,
    required this.link,
    required this.imageLinks,
    required this.uid,
    required this.userProfilePic,
    required this.resharedProfilePic,
    required this.resharedByUid,
    required this.postType,
    required this.postedAt,
    required this.likes,
    required this.commentIds,
    required this.id,
    required this.reshareCount,
    required this.resharedBy,
    required this.repliedTo,
  });

  PostModel copyWith({
    String? text,
    List<String>? hashtags,
    String? link,
    List<String>? imageLinks,
    String? uid,
    String? userProfilePic,
    String? resharedProfilePic,
    String? resharedByUid,
    PostType? postType,
    DateTime? postedAt,
    DateTime? resharedAt,
    List<String>? likes,
    List<String>? commentIds,
    String? id,
    int? reshareCount,
    String? resharedBy,
    String? repliedTo,
  }) {
    return PostModel(
      text: text ?? this.text,
      hashtags: hashtags ?? this.hashtags,
      link: link ?? this.link,
      imageLinks: imageLinks ?? this.imageLinks,
      uid: uid ?? this.uid,
      userProfilePic: userProfilePic ?? this.userProfilePic,
      resharedProfilePic: resharedProfilePic ?? this.resharedProfilePic,
      resharedByUid: resharedByUid ?? this.resharedByUid,
      postType: postType ?? this.postType,
      postedAt: postedAt ?? this.postedAt,
      likes: likes ?? this.likes,
      commentIds: commentIds ?? this.commentIds,
      id: id ?? this.id,
      reshareCount: reshareCount ?? this.reshareCount,
      resharedBy: resharedBy ?? this.resharedBy,
      repliedTo: repliedTo ?? this.repliedTo,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'text': text});
    result.addAll({'hashtags': hashtags});
    result.addAll({'link': link});
    result.addAll({'imageLinks': imageLinks});
    result.addAll({'uid': uid});
    result.addAll({'userProfilePic': userProfilePic});
    result.addAll({'resharedProfilePic': resharedProfilePic});
    result.addAll({'resharedByUid': resharedByUid});
    result.addAll({'postType': postType.type});
    result.addAll({'postedAt': postedAt.millisecondsSinceEpoch});
    result.addAll({'likes': likes});
    result.addAll({'commentIds': commentIds});
    result.addAll({'reshareCount': reshareCount});
    result.addAll({'resharedBy': resharedBy});
    result.addAll({'repliedTo': repliedTo});

    return result;
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      text: map['text'] ?? '',
      hashtags: List<String>.from(map['hashtags']),
      link: map['link'] ?? '',
      imageLinks: List<String>.from(map['imageLinks']),
      uid: map['uid'] ?? '',
      userProfilePic: map['userProfilePic'] ?? '',
      resharedProfilePic: map['resharedProfilePic'] ?? '',
      resharedByUid: map['resharedByUid'] ?? '',
      postType: (map['postType'] as String).toPostTypeEnum(),
      postedAt: DateTime.fromMillisecondsSinceEpoch(map['postedAt']),
      likes: List<String>.from(map['likes']),
      commentIds: List<String>.from(map['commentIds']),
      id: map['\$id'] ?? '',
      reshareCount: map['reshareCount']?.toInt() ?? 0,
      resharedBy: map['resharedBy'] ?? '',
      repliedTo: map['repliedTo'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Tweet(text: $text, hashtags: $hashtags, link: $link, imageLinks: $imageLinks, uid: $uid, userProfilePic: $userProfilePic, resharedProfilePic: $resharedProfilePic, resharedByUid: $resharedByUid, postType: $postType, postedAt: $postedAt, likes: $likes, commentIds: $commentIds, id: $id, reshareCount: $reshareCount, resharedBy: $resharedBy, repliedTo: $repliedTo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostModel &&
        other.text == text &&
        listEquals(other.hashtags, hashtags) &&
        other.link == link &&
        listEquals(other.imageLinks, imageLinks) &&
        other.uid == uid &&
        other.userProfilePic == userProfilePic &&
        other.resharedProfilePic == resharedProfilePic &&
        other.resharedByUid == resharedByUid &&
        other.postType == postType &&
        other.postedAt == postedAt &&
        listEquals(other.likes, likes) &&
        listEquals(other.commentIds, commentIds) &&
        other.id == id &&
        other.reshareCount == reshareCount &&
        other.resharedBy == resharedBy &&
        other.repliedTo == repliedTo;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        hashtags.hashCode ^
        link.hashCode ^
        imageLinks.hashCode ^
        uid.hashCode ^
        userProfilePic.hashCode ^
        resharedProfilePic.hashCode ^
        resharedByUid.hashCode ^
        postType.hashCode ^
        postedAt.hashCode ^
        likes.hashCode ^
        commentIds.hashCode ^
        id.hashCode ^
        reshareCount.hashCode ^
        resharedBy.hashCode ^
        repliedTo.hashCode;
  }
}
