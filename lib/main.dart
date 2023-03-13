import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/common/common.dart';
import 'package:linkedin/features/auth/controllers/auth_controller.dart';
import 'package:linkedin/features/auth/views/signin_view.dart';
import 'package:linkedin/features/home/views/home_view.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;
import 'theme/theme.dart';

void main() {
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LinkedIn',
      theme: AppTheme.theme,
      home: Consumer(
        builder: (context, ref, child) {
          return ref.watch(currentUserProvider).when(
                data: (user) {
                  if (user != null) {
                    return const HomeView();
                  }
                  return const SignInView();
                },
                loading: () => const LoadingPage(),
                error: (error, stack) => ErrorPage(error: error.toString()),
              );
        },
      ),
    );
  }
}
