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
  final String companyLogo;
  final String jobLocation;
  final bool isBookmarked;
  const JobModel({
    required this.jobDescription,
    required this.link,
    required this.uid,
    required this.userProfilePic,
    required this.postedAt,
    required this.id,
    required this.company,
    required this.companyLogo,
    required this.jobLocation,
    required this.isBookmarked,
  });

  JobModel copyWith({
    String? jobDescription,
    String? link,
    String? uid,
    String? userProfilePic,
    DateTime? postedAt,
    String? id,
    String? company,
    String? companyLogo,
    String? jobLocation,
    bool? isBookmarked,
  }) {
    return JobModel(
      jobDescription: jobDescription ?? this.jobDescription,
      link: link ?? this.link,
      uid: uid ?? this.uid,
      userProfilePic: userProfilePic ?? this.userProfilePic,
      postedAt: postedAt ?? this.postedAt,
      id: id ?? this.id,
      company: company ?? this.company,
      companyLogo: companyLogo ?? this.companyLogo,
      jobLocation: jobLocation ?? this.jobLocation,
      isBookmarked: isBookmarked ?? this.isBookmarked,
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
    result.addAll({'companyLogo': companyLogo});
    result.addAll({'jobLocation': jobLocation});
    result.addAll({'isBookmarked': isBookmarked});

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
      companyLogo: map['companyLogo'] ?? '',
      jobLocation: map['jobLocation'] ?? '',
      isBookmarked: map['isBookmarked'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Tweet(jobDescription: $jobDescription, link: $link, uid: $uid, userProfilePic: $userProfilePic, postedAt: $postedAt, id: $id, company: $company, companyLogo: $companyLogo, jobLocation: $jobLocation, isBookmarked: $isBookmarked)';
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
        other.companyLogo == companyLogo &&
        other.jobLocation == jobLocation &&
        other.isBookmarked == isBookmarked;
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
        companyLogo.hashCode ^
        jobLocation.hashCode ^
        isBookmarked.hashCode;
  }
}
