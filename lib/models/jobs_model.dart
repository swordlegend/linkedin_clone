import 'package:flutter/foundation.dart';

@immutable
class JobModel {
  final String jobDescription;
  final String link;
  final String uid;
  final String userProfilePic;
  final DateTime postedAt;
  final String id;
  final String company;
  final String position;
  final String jobLocation;
  final String jobType;
  const JobModel({
    required this.jobDescription,
    required this.link,
    required this.uid,
    required this.userProfilePic,
    required this.postedAt,
    required this.id,
    required this.company,
    required this.position,
    required this.jobLocation,
    required this.jobType,
  });

  JobModel copyWith({
    String? jobDescription,
    String? link,
    String? uid,
    String? userProfilePic,
    DateTime? postedAt,
    String? id,
    String? company,
    String? position,
    String? jobLocation,
    String? jobType,
  }) {
    return JobModel(
      jobDescription: jobDescription ?? this.jobDescription,
      link: link ?? this.link,
      uid: uid ?? this.uid,
      userProfilePic: userProfilePic ?? this.userProfilePic,
      postedAt: postedAt ?? this.postedAt,
      id: id ?? this.id,
      company: company ?? this.company,
      position: position ?? this.position,
      jobLocation: jobLocation ?? this.jobLocation,
      jobType: jobType ?? this.jobType,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'jobDescription': jobDescription});
    result.addAll({'link': link});
    result.addAll({'uid': uid});
    result.addAll({'userProfilePic': userProfilePic});
    result.addAll({'postedAt': postedAt.millisecondsSinceEpoch});
    result.addAll({'company': company});
    result.addAll({'position': position});
    result.addAll({'jobLocation': jobLocation});
    result.addAll({'jobType': jobType});

    return result;
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      jobDescription: map['jobDescription'] ?? '',
      link: map['link'] ?? '',
      uid: map['uid'] ?? '',
      userProfilePic: map['userProfilePic'] ?? '',
      postedAt: DateTime.fromMillisecondsSinceEpoch(map['postedAt']),
      id: map['\$id'] ?? '',
      company: map['company'] ?? '',
      position: map['position'] ?? '',
      jobLocation: map['jobLocation'] ?? '',
      jobType: map['jobType'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Tweet(jobDescription: $jobDescription, link: $link, uid: $uid, userProfilePic: $userProfilePic, postedAt: $postedAt, id: $id, company: $company, position: $position, jobLocation: $jobLocation, jobType: $jobType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JobModel &&
        other.jobDescription == jobDescription &&
        other.link == link &&
        other.uid == uid &&
        other.userProfilePic == userProfilePic &&
        other.postedAt == postedAt &&
        other.id == id &&
        other.company == company &&
        other.position == position &&
        other.jobLocation == jobLocation &&
        other.jobType == jobType;
  }

  @override
  int get hashCode {
    return jobDescription.hashCode ^
        link.hashCode ^
        uid.hashCode ^
        userProfilePic.hashCode ^
        postedAt.hashCode ^
        id.hashCode ^
        company.hashCode ^
        position.hashCode ^
        jobLocation.hashCode ^
        jobType.hashCode;
  }
}
