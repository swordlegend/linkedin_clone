import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/apis/user_api.dart';

final networkControllerProvider =
    StateNotifierProvider<NetworkControllerNotifier, bool>((ref) {
  return NetworkControllerNotifier(
    userAPI: ref.watch(userApiProvider),
  );
});

final listUserProvider = FutureProvider.autoDispose((ref) async {
  final networkController = ref.watch(networkControllerProvider.notifier);
  return networkController.getAllUsers();
});

class NetworkControllerNotifier extends StateNotifier<bool> {
  final UserApi _userAPI;
  NetworkControllerNotifier({
    required UserApi userAPI,
  })  : _userAPI = userAPI,
        super(false);

  Future<List> getAllUsers() async {
    return _userAPI.getAllUsers();
  }
}
