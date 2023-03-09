import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/features/auth/controllers/auth_controller.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeView(),
      );
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home'),
            Consumer(builder: (context, ref, child) {
              return TextButton(
                onPressed: () {
                  ref.read(authControllerProvider.notifier).logout(context);
                },
                child: const Text('Sign Out'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
