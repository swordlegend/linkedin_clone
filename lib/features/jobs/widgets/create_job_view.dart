import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/common/common.dart';
import 'package:linkedin/features/auth/controllers/auth_controller.dart';
import 'package:linkedin/features/jobs/controllers/jobs_controller.dart';
import 'package:linkedin/theme/theme.dart';

class CreateJobView extends ConsumerStatefulWidget {
  const CreateJobView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateJobViewState();
}

class _CreateJobViewState extends ConsumerState<CreateJobView> {
  TextEditingController companyName = TextEditingController();
  TextEditingController jobDescription = TextEditingController();
  TextEditingController jobLocation = TextEditingController();

  void postJob() {
    ref.read(jobsControllerProvider.notifier).createJobPost(
          company: companyName.text,
          jobDescription: jobDescription.text,
          jobLocation: jobLocation.text,
          context: context,
        );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailProvider);
    final isLoading = ref.watch(jobsControllerProvider);

    return isLoading
        ? const Loader()
        : currentUser.when(
            data: (data) {
              return AlertDialog(
                backgroundColor: Pallete.backgroundColor,
                content: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    children: [
                      const Text('Create Job Post'),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Company Name',
                            border: OutlineInputBorder(),
                          ),
                          controller: companyName,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Job Description',
                            border: OutlineInputBorder(),
                          ),
                          controller: jobDescription,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Job Location',
                            border: OutlineInputBorder(),
                          ),
                          controller: jobLocation,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              companyName.clear();
                              jobDescription.clear();
                              jobLocation.clear();
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: postJob,
                            child: const Text('Post'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (e, stackTrace) => ErrorPage(error: e.toString()),
            loading: () => const Loader(),
          );
  }
}
