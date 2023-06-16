import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/common/common.dart';
import 'package:linkedin/features/network/controller/network_controller.dart';
import 'package:linkedin/features/profile/views/profile_views.dart';
import 'package:linkedin/theme/theme.dart';

class NetworkView extends ConsumerStatefulWidget {
  const NetworkView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NetworkViewState();
}

class _NetworkViewState extends ConsumerState<NetworkView> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(listUserProvider).when(
          data: (users) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: users.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  final usr = users[index];
                  return Container(
                    height: 140,
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Pallete.blueColor,
                        width: 0.8,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: 32,
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  color: Colors.grey,
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 4.0),
                                      child: Icon(Icons.close),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      ProfileView.route(usr.data['\$id']),
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      usr.data['profilePic'],
                                    ),
                                    radius: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              ProfileView.route(usr.data['\$id']),
                            );
                          },
                          child: Text(
                            usr.data['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          usr.data['bio'],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 4),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Connect'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Loader(),
          error: (error, stack) => ErrorPage(error: error.toString()),
        );
  }
}
