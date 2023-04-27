// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:buddies/services/navigation_service.dart';
import 'package:buddies/services/routes/routes.dart';
import 'package:buddies/settings/app_theme.dart';

class BottomBar extends StatefulWidget {
  BottomBar({Key? key, required this.currentIndex}) : super(key: key);

  int currentIndex;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 12,
        ),
        height: 100,
        color: AppTheme.bottomBarColor,
        child: Center(
          child: Row(
            children: [
              buttonWidget(
                  icon: SizedBox(
                    width: 20,
                    height: 25,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/buddies.svg',
                        color: (widget.currentIndex == 0)
                            ? AppTheme.redColor
                            : AppTheme.textColor,
                      ),
                    ),
                  ),
                  title: 'Buddies',
                  textColor: (widget.currentIndex == 0)
                      ? AppTheme.redColor
                      : AppTheme.textColor,
                  onTap: () {
                    setState(() {
                      widget.currentIndex = 0;
                    });
                    goHome();
                  }),
              buttonWidget(
                icon: SizedBox(
                  width: 33,
                  height: 25,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/discover.svg',
                      color: (widget.currentIndex == 1)
                          ? AppTheme.redColor
                          : AppTheme.textColor,
                    ),
                  ),
                ),
                title: 'Discover',
                textColor: (widget.currentIndex == 1)
                    ? AppTheme.redColor
                    : AppTheme.textColor,
                onTap: () {
                  setState(() {
                    widget.currentIndex = 1;
                  });
                },
              ),
              buttonWidget(
                  icon: SizedBox(
                    width: 28,
                    height: 2,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/settings.svg',
                        color: (widget.currentIndex == 2)
                            ? AppTheme.redColor
                            : AppTheme.textColor,
                      ),
                    ),
                  ),
                  title: 'Settings',
                  textColor: (widget.currentIndex == 2)
                      ? AppTheme.redColor
                      : AppTheme.textColor,
                  onTap: () {
                    setState(() {
                      widget.currentIndex = 2;
                    });
                    NavigationService.instance.navigateTo(Routes.settings);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  buttonWidget(
      {required Widget icon,
      required String title,
      void Function()? onTap,
      Color? textColor}) {
    return Expanded(
        child: Center(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              width: 35,
              height: 35,
              child: icon,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: AppTheme.caption1.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    ));
  }
}
