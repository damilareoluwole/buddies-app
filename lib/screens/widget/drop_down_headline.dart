// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:buddies/settings/app_theme.dart';

Widget twoColumnHeadline({required String title, required Function onTap}) {
  return Column(
    children: [
      InkWell(
        onTap: () {
          onTap;
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTheme.settingsHeader.copyWith(
                fontSize: 13,
              ),
            ),
            SvgPicture.asset("assets/icons/chevron_right.svg"),
          ],
        ),
      ),
      SizedBox(
        height: 12,
      ),
    ],
  );
}

Widget twoColumnHeadlineWithSvg(
    {required String title, required onTap, required String image}) {
  return Column(
    children: [
      InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(image),
                SizedBox(
                  width: 8,
                ),
                Text(
                  title,
                  style: AppTheme.settingsHeader.copyWith(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            SvgPicture.asset("assets/icons/chevron_right.svg"),
          ],
        ),
      ),
      SizedBox(
        height: 8,
      ),
    ],
  );
}
