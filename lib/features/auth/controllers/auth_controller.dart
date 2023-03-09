import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/apis/auth_api.dart';
import 'package:linkedin/core/core.dart';
import 'package:linkedin/features/auth/views/signin_view.dart';
import 'package:linkedin/features/home/views/home_view.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(authApi: ref.watch(authApiProvider));
});

final currentUserProvider = FutureProvider.autoDispose((ref) async {
  return ref.watch(authControllerProvider.notifier).getCurrentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthApi _authApi;
  AuthController({
    required AuthApi authApi,
  })  : _authApi = authApi,
        super(false);

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _authApi.signIn(
      email: email,
      password: password,
    );
    result.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'SignIn successful');
      Navigator.pushReplacement(context, HomeView.route());
    });
    state = false;
  }

  Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _authApi.signUp(
      email: email,
      password: password,
    );
    result.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Account created successfully');
      Navigator.pushReplacement(context, SignInView.route());
    });
    state = false;
  }

  Future getCurrentUser() => _authApi.getCurrentUser();

  Future<void> googleSignIn(BuildContext context) async {
    state = true;
    final result = await _authApi.googleSignIn();
    result.fold((l) => showSnackBar(context, l.message), (r) {
      Navigator.pushReplacement(context, HomeView.route());
    });
    state = false;
  }

  Future<void> logout(BuildContext context) async {
    state = true;
    final res = await _authApi.logout();
    res.fold((l) => null, (r) {
      Navigator.pushAndRemoveUntil(
        context,
        SignInView.route(),
        (route) => false,
      );
    });
    state = false;
  }
}