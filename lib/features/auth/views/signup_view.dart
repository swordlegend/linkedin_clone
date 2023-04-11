import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/common/common.dart';
import 'package:linkedin/constants/constants.dart';
import 'package:linkedin/features/auth/controllers/auth_controller.dart';
import 'package:linkedin/features/auth/views/signin_view.dart';
import 'package:linkedin/features/auth/widgets/auth_field.dart';
import 'package:linkedin/features/auth/widgets/google_button.dart';
import 'package:linkedin/theme/theme.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpView(),
      );
  const SignUpView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  void onGoogleSignUp() {
    ref.read(authControllerProvider.notifier).googleSignIn(context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    final theme = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: appbar,
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.brightness == Brightness.dark
                            ? Pallete.lightBackgroundColor
                            : Pallete.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: theme.brightness == Brightness.dark
                                ? Pallete.backgroundColor
                                : Pallete.greyColor,
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 24.0,
                                top: 12.0,
                              ),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 26,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.only(left: 24.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Join LinkedIn today and build your career.',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                            ),
                            child: AuthField(
                              controller: emailController,
                              hintText: 'Email',
                            ),
                          ),
                          const SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                            ),
                            child: AuthField(
                              controller: passwordController,
                              hintText: 'Password',
                              isPassword: true,
                            ),
                          ),
                          const SizedBox(height: 26),
                          Align(
                            alignment: Alignment.center,
                            child: RoundedSmallButton(
                              onTap: onSignUp,
                              label: 'Accept & Join',
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Divider(
                            indent: 16.0,
                            endIndent: 16.0,
                            thickness: 2,
                          ),
                          const SizedBox(height: 16),
                          GoogleButton(
                            label: 'Sign up with Google',
                            onPressed: onGoogleSignUp,
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: RichText(
                              text: TextSpan(
                                text: 'Already registered?',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: theme.textTheme.bodyMedium!.color!,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' Log In',
                                    style: const TextStyle(
                                      color: Pallete.blueColor,
                                      fontSize: 18,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                          context,
                                          SignInView.route(),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
