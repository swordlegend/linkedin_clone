import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:linkedin/common/common.dart';
import 'package:linkedin/constants/constants.dart';
import 'package:linkedin/features/auth/views/signin_view.dart';
import 'package:linkedin/features/auth/widgets/auth_field.dart';
import 'package:linkedin/theme/theme.dart';

class SignUpView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpView(),
      );
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    final appbar = UIConstants.appBar();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    // @override
    // void dispose() {
    //   emailController.dispose();
    //   passwordController.dispose();
    //   super.dispose();
    // }

    void onSignUp() {}

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Container(
                decoration: BoxDecoration(
                  color: Pallete.lightBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Pallete.backgroundColor,
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account?',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          children: [
                            TextSpan(
                              text: ' Sign In',
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
