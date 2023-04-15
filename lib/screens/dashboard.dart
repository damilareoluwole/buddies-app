// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:buddies/models/user.dart';
import 'package:buddies/screens/frame/app_frame.dart';
import 'package:buddies/screens/frame/app_menu.dart';
import 'package:buddies/screens/frame/bottom_bar.dart';
import 'package:buddies/services/navigation_service.dart';
import 'package:buddies/services/routes/routes.dart';
import 'package:buddies/settings/app_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var drawerOpen = false;

  late final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppTheme.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/menu.svg',
              height: 20,
            ),
            onPressed: () {
              if (_scaffoldKey.currentState!.isDrawerOpen == false) {
                _scaffoldKey.currentState!.openDrawer();
              } else {
                _scaffoldKey.currentState!.closeDrawer();
              }
            }),
        centerTitle: true,
        title: SizedBox(
          height: 32,
          child: Center(
            child: Image.asset('assets/images/logo_white.png'),
          ),
        ),
        actions: [
          IconButton(
              icon: SvgPicture.asset(
                'assets/icons/avata.svg',
                height: 22,
              ),
              onPressed: () {
                NavigationService.instance.navigateTo(Routes.editProfile);
              }),
          const SizedBox(width: 12)
        ],
      ),
      drawer: AppMenu(),
      onDrawerChanged: (val) {
        setState(() {
          drawerOpen = val;
        });
      },
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppTheme.pink2,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Welcome ${user.name}',
                  style: AppTheme.caption2,
                )
              ],
            ),
          ),
          SizedBox(height: 18),
          Container(
            padding: containerPaddingSmall,
            child: Column(
              children: [
                Text(
                  'Hey there, below is a grid list of the buddies. Meet. network and have fun!!!',
                  style: AppTheme.caption1.copyWith(color: AppTheme.grey),
                ),
              ],
            ),
          ),
        ],
      )),
      bottomNavigationBar: BottomBar(currentIndex: 0),
    );
  }
}
