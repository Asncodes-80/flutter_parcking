import 'dart:async';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:securityapp/constFile/initStrings.dart';
import 'package:securityapp/constFile/initVar.dart';
import 'package:securityapp/controller/localDataController.dart';
import 'package:securityapp/controller/slotController.dart';
import 'package:securityapp/model/classes/ThemeColor.dart';
import 'package:securityapp/widgets/CustomText.dart';
import 'package:securityapp/widgets/shrinkMenuBuilder.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:sizer/sizer.dart';

String token = "";
String fullname = "";
String avatar = "";
// LocalStorage Controller Class
LoadingLocalData LLDs = LoadingLocalData();

// Slot Viewer
SlotsViewer slotView = SlotsViewer();
Map slotsMap = {};

// Set for getting data
Timer timer;

class Maino extends StatefulWidget {
  @override
  _MainoState createState() => _MainoState();
}

class _MainoState extends State<Maino> {
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 60), (timer) => findContent());
    findContent();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  // Section for finding content function
  void findContent() {
    // Getting data from Secure storage
    LLDs.gettingStaffInfoInLocal().then((local) {
      setState(() {
        token = local["token"];
        fullname = local["fullname"];
        avatar = local["avatar"];
      });
    });
    // getting tiles of slot grid
    slotView.gettingSlots().then((slots) => setState(() {
          slotsMap = slots;
          // print(slots);
          // print(slotsMap['floors'][0]);
          // final test = slots["${slotsMap['floors']}"];
          // print("This =======> $test");

          print(slotsMap["${slotsMap['floors'][4]}"] == null
              ? "nulllll"
              : "okay");
          // print(slotsMap["-5"].length);
          // print(slotsMap['floors']);
          // print(slotsMap['floors'][4]);

          // print(slotsMap['floors'].length);
          // print(slotsMap["${slotsMap['floors'][0]}"].length);
          // print(slotsMap['floors']);
          // print(slots["${slots['floors'][0]}"][0]['key']);
          // print(slots["${slots['floors'][0]}"][0]);
          // print(slotsMap["${slotsMap['floors'][-1]}"].length);
        }));
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

    // Config Animated list
    final options = LiveOptions(
      // Start animation after (default zero)
      delay: Duration(milliseconds: 100),

      // Show each item through (default 250)
      showItemInterval: Duration(milliseconds: 50),

      // Animation duration (default 250)
      showItemDuration: Duration(milliseconds: 700),

      // Animations starts at 0.05 visible
      // item fraction in sight (default 0.025)
      visibleFraction: 0.5,

      // Repeat the animation of the appearance
      // when scrolling in the opposite direction (default false)
      // To get the effect as in a showcase for ListView, set true
      reAnimateOnVisibility: false,
    );

    final gridContext = slotsMap.isEmpty
        ? SizedBox()
        : LiveList.options(
            shrinkWrap: true,
            primary: false,
            itemCount:
                slotsMap['floors'] != null ? slotsMap['floors'].length - 1 : 0,
            itemBuilder:
                (BuildContext context, int item, Animation<double> animation) =>
                    FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(animation),
              child: SlideTransition(
                position:
                    Tween<Offset>(begin: Offset(0, -0.1), end: Offset.zero)
                        .animate(animation),
                child: Column(
                  children: [
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: CustomText(
                            text: "${slotsMap["floors"][item]} طبقه ",
                            size: 16.0.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.0.h),
                    LiveGrid.options(
                      options: options,
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: slotsMap["${slotsMap['floors'][item]}"] != null
                          ? slotsMap["${slotsMap['floors'][item]}"].length - 1
                          : 0,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index,
                              Animation<double> animation) =>
                          FadeTransition(
                        opacity:
                            Tween<double>(begin: 0, end: 1).animate(animation),
                        // And slide transition
                        child: SlideTransition(
                          position: Tween<Offset>(
                                  begin: Offset(0, -0.1), end: Offset.zero)
                              .animate(animation),
                          child: Container(
                            decoration: BoxDecoration(
                                color: slotsMap["${slotsMap['floors'][item]}"]
                                            [index]["status"] ==
                                        0
                                    ? empty
                                    : slotsMap["${slotsMap['floors'][item]}"]
                                                [index]["status"] ==
                                            1
                                        ? fullSlot
                                        : reserve,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 1,
                                )),
                            child: Center(
                              child: CustomText(
                                size: 13.0.sp,
                                // slotsMap["${slotsMap['floors'][item]}"][index]["id"]
                                text:
                                    "P ${slotsMap["${slotsMap['floors'][item]}"][index]["id"]}",
                                color: slotsMap["${slotsMap['floors'][item]}"]
                                            [index]["status"] ==
                                        1
                                    ? Colors.white
                                    : slotsMap["${slotsMap['floors'][item]}"]
                                                [index]["status"] ==
                                            -1
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            options: options,
          );

    final slotsContainer = slotsMap.isNotEmpty
        ? gridContext
        : Column(
            children: [
              Lottie.asset("assets/animation/buildings.json"),
              CustomText(
                text: "در حال دریافت اطلاعات",
              ),
            ],
          );

    return WillPopScope(
      onWillPop: () =>
          SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      child: SideMenu(
        key: _sideMenuKey,
        inverse: true,
        background: themeChange.darkTheme ? sideColorDark : sideColorLight,
        closeIcon: Icon(Icons.close,
            color: themeChange.darkTheme ? Colors.white : Colors.black),
        type: SideMenuType.slideNRotate,
        menu: buildMenu(
          themeChange: themeChange,
          context: context,
          // Will Change from api in lds + avatar
          avatar: avatar,
          fullname: fullname,
        ),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: appBarColor,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/hamrahLogoAppBar.png",
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  final _state = _sideMenuKey.currentState;
                  if (_state.isOpened)
                    _state.closeSideMenu();
                  else
                    _state.openSideMenu();
                },
              ),
            ],
            title: CustomText(
              text: securityAppBarText,
              fw: FontWeight.bold,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 4.0.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        CustomText(
                          text: slotsTitleText,
                          size: 15.0.sp,
                          fw: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.0.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: slotsContainer,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
