import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/apis/user_api.dart';
import 'package:linkedin/models/user_model.dart';

final searchControllerProvider = StateNotifierProvider((ref) {
  return SearchController(
    userAPI: ref.watch(userApiProvider),
  );
});

final searchUserProvider = FutureProvider.family((ref, String name) async {
  final searchController = ref.watch(searchControllerProvider.notifier);
  return searchController.searchUser(name);
});

class SearchController extends StateNotifier<bool> {
  final UserApi _userAPI;
  SearchController({
    required UserApi userAPI,
  })  : _userAPI = userAPI,
        super(false);

  Future<List<UserModel>> searchUser(String name) async {
    final users = await _userAPI.searchUserByName(name);
    return users.map((e) => UserModel.fromMap(e.data)).toList();
  }
}