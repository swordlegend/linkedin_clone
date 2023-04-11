import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linkedin/constants/constants.dart';
import 'package:linkedin/theme/theme.dart';

class GoogleButton extends ConsumerWidget {
  final String label;
  final double horizontalPadding;
  final VoidCallback onPressed;
  const GoogleButton({
    Key? key,
    required this.label,
    this.horizontalPadding = 70,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);
    return TextButton.icon(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        AssetsConstants.googleSvg,
        width: 21,
        colorFilter: ColorFilter.mode(
          theme.textTheme.bodyMedium!.color!,
          BlendMode.srcIn,
        ),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: theme.textTheme.bodyMedium!.color!,
          fontSize: 14,
        ),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 22,
          horizontal: horizontalPadding,
        ),
        shape: const StadiumBorder(
          side: BorderSide(
            color: Pallete.blueColor,
            width: 1,
          ),
        ),
      ),
    );
  }
}
