import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/apis/auth_api.dart';
import 'package:linkedin/apis/user_api.dart';
import 'package:linkedin/core/core.dart';
import 'package:linkedin/features/auth/views/signin_view.dart';
import 'package:linkedin/features/home/views/home_view.dart';
import 'package:linkedin/models/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authApi: ref.watch(authApiProvider),
    userApi: ref.watch(userApiProvider),
  );
});

final currentUserProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(authControllerProvider.notifier).getCurrentUser();
});

final currentUserDetailProvider = FutureProvider.autoDispose((ref) {
  final uid = ref.watch(currentUserProvider).value!.$id;
  final userDetail = ref.watch(authControllerProvider.notifier).getUserData(uid);
  return userDetail;
});

class AuthController extends StateNotifier<bool> {
  final AuthApi _authApi;
  final UserApi _userApi;
  AuthController({
    required AuthApi authApi,
    required UserApi userApi,
  })  : _authApi = authApi,
        _userApi = userApi,
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
    result.fold((l) => showSnackBar(context, l.message), (r) async {
      UserModel user = UserModel(
        email: email,
        name: getNameFromEmail(email),
        profilePic: 'https://avatars.githubusercontent.com/u/62945306?v=4',
        bannerPic: '',
        uid: r.$id,
        bio: '',
      );
      final res = await _userApi.saveUserData(user);
      res.fold((l) => showSnackBar(context, l.message), (r) {
        showSnackBar(context, 'Account created successfully');
        Navigator.pushReplacement(context, SignInView.route());
      });
    });
    state = false;
  }

  Future getCurrentUser() => _authApi.getCurrentUser();

  Future<UserModel> getUserData(String uid) async {
    Future.delayed(const Duration(seconds: 2));
    final document = await _userApi.getUserData(uid);
    final updatedUser = UserModel.fromMap(document.data);
    return updatedUser;
  }

  Future<void> googleSignIn(BuildContext context) async {
    state = true;
    final result = await _authApi.googleSignIn();
    result.fold((l) => showSnackBar(context, l.message), (r) {
      // Future.delayed(const Duration(seconds: 2), () {
      //   Navigator.pushReplacement(context, HomeView.route());
      // });
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
