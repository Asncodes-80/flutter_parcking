import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payausers/Model/ApiAccess.dart';
import 'package:payausers/Model/ThemeColor.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startingTimer();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final mainTitleLogo = themeChange.darkTheme
        ? "assets/images/Titile_Logo_Mark_dark.png"
        : "assets/images/Titile_Logo_Mark_light.png";
    return WillPopScope(
      onWillPop: () =>
          SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              child: Image.asset(
                mainTitleLogo,
                width: 200,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void startingTimer() {
    Timer(Duration(milliseconds: 100), () {
      navigatedToRoot(); //It will redirect  after 5 microseconds
    });
  }

  void navigatedToRoot() async {
    ApiAccess api = ApiAccess();
    final lStorage = FlutterSecureStorage();
    final userToken = await lStorage.read(key: "token");
    final localAuthPasas = await lStorage.read(key: "local_lock");

    if (userToken != null) {
      // try {
      // Getting data from api Access
      // final userAccountStatus =
      // await api.getUserStatusAccount(token: userToken);
      // if (userAccountStatus['status'] != "disable") {
      if (localAuthPasas != null) // And And our boolean lock status show
        Navigator.pushNamed(context, "/localAuth");
      else
        Navigator.pushNamed(context, "/dashboard");
      // } else {
      // user is not active
      // }
      // } catch (e) {
      // Network or API Error
      // Navigator.pushNamed(context, '/checkConnection');
      // print("Error form getting status of user for entring dashboard $e");
      // }
    } else
      Navigator.pushNamed(context, '/');
  }
}
