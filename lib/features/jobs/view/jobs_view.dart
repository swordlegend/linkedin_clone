import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/common/common.dart';
import 'package:linkedin/features/jobs/controllers/jobs_controller.dart';

class JobsView extends ConsumerWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const JobsView(),
      );
  const JobsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getJobsProvider).when(
          data: (jobs) {
            return ListView.builder(
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index];
                return Card(
                  child: ListTile(
                    title: Text(job.jobDescription),
                    subtitle: Text(job.company),
                    trailing: Text(job.jobType),
                  ),
                );
              },
            );
          },
          loading: () => const LoadingPage(),
          error: (error, stack) => ErrorPage(error: error.toString()),
        );
  }
}
