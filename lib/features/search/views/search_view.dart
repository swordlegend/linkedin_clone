import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/common/common.dart';
import 'package:linkedin/features/search/controller/search_conreoller.dart';
import 'package:linkedin/features/search/widgets/search_tile.dart';
import 'package:linkedin/theme/theme.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  final searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeNotifierProvider);
    final appBarTextFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(
        color: ref.watch(themeNotifierProvider.notifier).mode == ThemeMode.dark
            ? Pallete.backgroundColor
            : Pallete.whiteColor,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 36,
          child: TextField(
            controller: searchController,
            onSubmitted: (value) {
              setState(() {
                isShowUsers = true;
              });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10).copyWith(
                left: 20,
              ),
              fillColor: ref.watch(themeNotifierProvider.notifier).mode ==
                      ThemeMode.dark
                  ? Pallete.backgroundColor
                  : Pallete.whiteColor,
              filled: true,
              enabledBorder: appBarTextFieldBorder,
              focusedBorder: appBarTextFieldBorder,
              hintText: 'Search',
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                // ignore: deprecated_member_use
                color: theme.textTheme.bodyText2!.color!,
              ),
            ),
          ),
        ),
      ),
      body: isShowUsers
          ? ref.watch(searchUserProvider(searchController.text)).when(
                data: (users) {
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int index) {
                      final user = users[index];
                      return SearchTile(userModel: user);
                    },
                  );
                },
                error: (error, st) => ErrorText(error: error.toString()),
                loading: () => const Loader(),
              )
          : const SizedBox(),
    );
  }
}
