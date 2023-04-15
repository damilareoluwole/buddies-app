import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:buddies/models/user.dart';
import 'package:buddies/screens/widget/logout.dart';
import 'package:buddies/services/navigation_service.dart';
import 'package:buddies/services/routes/routes.dart';
import 'package:buddies/settings/app_theme.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({super.key});

  @override
  Widget build(BuildContext context) {
    var width = 270.0;
    if (MediaQuery.of(context).size.width < width) {
      width = MediaQuery.of(context).size.width;
    }
    debugPrint(width.toString());
    return Drawer(
      backgroundColor: HexColor('#4D4D4D'),
      width: width,
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        color: HexColor('#333333'),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: HexColor('#4D4D4D'),
                child: Column(children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.topCenter,
                    child: InkWell(
                      child: profilePicture(),
                      onTap: () {
                        NavigationService.instance
                            .navigateTo(Routes.editProfile);
                      },
                    ),
                  ),
                  const SizedBox(height: 36),
                  Text(
                    user.name,
                    style:
                        AppTheme.caption1.copyWith(color: AppTheme.whiteColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 40),
                ]),
              ),
              Container(
                child: menuList(),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SEARCH',
                      style: AppTheme.caption1
                          .copyWith(color: AppTheme.whiteColor),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            'Football',
                            style: AppTheme.footnote
                                .copyWith(color: AppTheme.whiteColor),
                          ),
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          child: SizedBox(
                            width: 30,
                            height: 20,
                            child: SvgPicture.asset(
                                'assets/icons/menu/menu_search.svg'),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Divider(
                      thickness: 2,
                      color: AppTheme.whiteColor,
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

  Widget menuList() {
    return Column(children: [
      const SizedBox(height: 25),
      menuButton(
        icon: 'assets/icons/menu/menu_edit.svg',
        text: 'Edit Profile',
        onpress: () =>
            NavigationService.instance.navigateTo(Routes.editProfile),
      ),
      menuButton(
        icon: 'assets/icons/menu/menu_help.svg',
        text: 'Help',
        onpress: () {},
      ),
      menuButton(
        icon: 'assets/icons/menu/menu_safety.svg',
        text: 'Safety Center',
        onpress: () {},
      ),
      menuButton(
        icon: 'assets/icons/menu/menu_settings.svg',
        text: 'Settings',
        onpress: () {
          NavigationService.instance.navigateTo(Routes.settings);
        },
      ),
      menuButton(
        icon: 'assets/icons/menu/menu_partner.svg',
        text: 'Partners',
        onpress: () {},
      ),
      menuButton(
        icon: 'assets/icons/menu/menu_logout.svg',
        text: 'Logout',
        onpress: () {
          showModal(NavigationService.instance.getContext());
        },
      ),
    ]);
  }

  Widget menuButton(
      {required String icon,
      required String text,
      required Function() onpress,
      var isSelected = false,
      int count = 0}) {
    var iconColor = AppTheme.whiteColor;
    var iconWidget = Padding(
      padding: const EdgeInsets.only(top: 2),
      child: SvgPicture.asset(
        icon,
        height: 13,
        color: iconColor,
      ),
    );

    return InkWell(
      onTap: onpress,
      child: ListTile(
          minLeadingWidth: 15,
          leading: iconWidget,
          title: Text(
            text,
            style: AppTheme.subHeadline.copyWith(color: iconColor),
          )),
    );
  }

  Widget profilePicture() {
    return SizedBox(
      height: 70,
      child: SvgPicture.asset('assets/icons/profile.svg'),
    );
  }
}
