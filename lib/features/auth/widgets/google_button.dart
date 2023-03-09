import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linkedin/constants/constants.dart';
import 'package:linkedin/theme/theme.dart';

class GoogleButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        AssetsConstants.googleSvg,
        width: 21,
        colorFilter: const ColorFilter.mode(
          Pallete.whiteColor,
          BlendMode.srcIn,
        ),
      ),
      label: Text(
        label,
        style: const TextStyle(
          color: Pallete.whiteColor,
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
