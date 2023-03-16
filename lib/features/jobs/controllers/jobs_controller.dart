import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/apis/job_api.dart';
import 'package:linkedin/core/core.dart';
import 'package:linkedin/features/auth/controllers/auth_controller.dart';
import 'package:linkedin/models/jobs_model.dart';

final jobsControllerProvider = StateNotifierProvider<JobsController, bool>(
  (ref) {
    return JobsController(
      ref: ref,
      jobApi: ref.watch(jobApiProvider),
    );
  },
);

final getJobsProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(jobsControllerProvider.notifier).getJobPosts();
});

class JobsController extends StateNotifier<bool> {
  final JobApi _jobApi;
  final Ref _ref;
  JobsController({
    required JobApi jobApi,
    required Ref ref,
  })  : _jobApi = jobApi,
        _ref = ref,
        super(false);

  Future<List<JobModel>> getJobPosts() async {
    final posts = await _jobApi.getJobsPosts();
    return posts.map((posts) => JobModel.fromMap(posts.data)).toList();
  }

  void bookmark(
    JobModel jobModel,
    BuildContext context,
  ) async {
    bool isBookmarked = jobModel.isBookmarked;

    if (jobModel.isBookmarked == true) {
      isBookmarked = false;
    } else {
      isBookmarked = true;
    }
    jobModel.copyWith(isBookmarked: !isBookmarked);
    state = true;
    final res = await _jobApi.bookmarkJob(jobModel);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => showSnackBar(context, 'job bookmarked'),
    );
    state = false;
  }

  void createJobPost({
    required String jobDescription,
    required String company,
    required String jobLocation,
    required BuildContext context,
  }) async {
    if (jobDescription.isEmpty) {
      showSnackBar(context, 'Please enter job description');
      return;
    }

    state = true;
    String link = _getLinkFromText(jobDescription);
    final user = _ref.read(currentUserDetailProvider).value!;
    JobModel jobModel = JobModel(
      jobDescription: jobDescription,
      link: link,
      uid: user.uid,
      userProfilePic: user.profilePic,
      postedAt: DateTime.now(),
      id: '',
      company: company,
      companyLogo:
          'https://raw.githubusercontent.com/imobasshir/portfolio/main/images/preview.jpg',
      jobLocation: jobLocation,
      isBookmarked: false,
    );
    final res = await _jobApi.postJob(jobModel);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => showSnackBar(context, 'job posted'),
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
}
