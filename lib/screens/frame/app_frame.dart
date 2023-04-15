// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:buddies/screens/frame/app_menu.dart';
import 'package:buddies/services/helper.dart';
import 'package:buddies/services/routes/routes.dart';
import 'package:buddies/settings/app_theme.dart';
import 'package:buddies/screens/frame/bottom_bar.dart';

var contentHorizontalPadding = 24.0;
var contentVerticalPadding = 24.0;
var containerPadding = EdgeInsets.symmetric(
    vertical: contentVerticalPadding, horizontal: contentHorizontalPadding);

var containerPaddingSmall = EdgeInsets.symmetric(vertical: 12, horizontal: 12);

class AppFrame extends StatefulWidget {
  const AppFrame({
    Key? key,
    this.currentIndex = 0,
    required this.title,
    required this.child,
    this.floatingActionButton,
    this.floatingActionLocation,
    this.resizeToAvoidBottomInset,
    this.bottomNavigationBar,
    this.useScrowView = true,
  }) : super(key: key);
  final int currentIndex;
  final String title;
  final Widget child;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionLocation;
  final bool? resizeToAvoidBottomInset;
  final bool useScrowView;
  final Widget? bottomNavigationBar;

  @override
  State<AppFrame> createState() => _AppFrameState();
}

class _AppFrameState extends State<AppFrame> {
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
          icon: SvgPicture.asset('assets/icons/chevron_left.svg'),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Helper().popScreen(context);
            } else {
              goHome();
            }
          },
        ),
        centerTitle: true,
        title: Text(
          widget.title,
          style: AppTheme.callout,
        ),
        actions: [
          IconButton(
              icon: SvgPicture.asset(
                'assets/icons/menu.svg',
                height: 22,
              ),
              onPressed: () {
                if (_scaffoldKey.currentState!.isDrawerOpen == false) {
                  _scaffoldKey.currentState!.openDrawer();
                } else {
                  _scaffoldKey.currentState!.closeDrawer();
                }
              }),
          const SizedBox(width: 24)
        ],
      ),
      drawer: AppMenu(),
      onDrawerChanged: (val) {
        setState(() {
          drawerOpen = val;
        });
      },
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      body: SafeArea(
        //minimum: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: (widget.useScrowView)
            ? SingleChildScrollView(child: widget.child)
            : Container(child: widget.child),
      ),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionLocation,
      bottomNavigationBar: widget.bottomNavigationBar ??
          BottomBar(currentIndex: widget.currentIndex),
    );
  }
}
