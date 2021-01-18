import 'package:flutter/material.dart';
import 'package:payausers/Classes/ThemeColor.dart';
import 'package:payausers/ConstFiles/constText.dart';
import 'package:payausers/ConstFiles/initialConst.dart';
import 'package:payausers/ExtractedWidgets/bottomBtnNavigator.dart';
import 'package:payausers/ExtractedWidgets/textField.dart';
import 'package:provider/provider.dart';

String personalCode = "";
String password = "";
dynamic emptyTextFieldErrPersonalCode = null;
dynamic emptyTextFieldErrPassword = null;

IconData showMePass = Icons.remove_red_eye;

bool protectedPassword = true;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // Setting dark theme provider class
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final String mainImgLogoLightMode =
        "assets/images/Titile_Logo_Mark_light.png";
    final String mainImgLogoDarkMode =
        "assets/images/Titile_Logo_Mark_dark.png";
    final String mainLogo =
        themeChange.darkTheme ? mainImgLogoDarkMode : mainImgLogoLightMode;
    // Final Navigation to? it's super temporary
    void navigatedToDashboard() => Navigator.pushNamed(context, '/dashboard');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loginAppBarText,
          style: TextStyle(fontFamily: mainFaFontFamily, color: Colors.white),
        ),
        backgroundColor: appBarColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Center(
                  child: Image.asset(mainLogo, width: 250),
                ),
              ),
              SizedBox(height: 30),
              Text(
                welcomeToInfo,
                style: TextStyle(
                  fontFamily: mainFaFontFamily,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              TextFields(
                lblText: personalCodePlaceHolder,
                textFieldIcon: Icons.account_circle,
                textInputType: false,
                readOnly: false,
                // errText:
                //     emptyTextFieldErrEmail == null ? null : emptyTextFieldMsg,
                onChangeText: (onChangeUsername) {
                  setState(() {
                    emptyTextFieldErrPersonalCode = null;
                    personalCode = onChangeUsername;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFields(
                lblText: passwordPlaceHolder,
                maxLen: 20,
                readOnly: false,
                // errText: emptyTextFieldErrPassword == null
                //     ? null
                //     : emptyTextFieldMsg,
                textInputType: protectedPassword,
                textFieldIcon:
                    password == "" ? Icons.vpn_key_outlined : showMePass,
                iconPressed: () {
                  setState(() {
                    protectedPassword
                        ? protectedPassword = false
                        : protectedPassword = true;
                    // Changing eye icon pressing
                    showMePass == Icons.remove_red_eye
                        ? showMePass = Icons.remove_red_eye_outlined
                        : showMePass = Icons.remove_red_eye;
                  });
                },
                onChangeText: (onChangePassword) {
                  setState(() {
                    emptyTextFieldErrPassword = null;
                    password = onChangePassword;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: FlatButton(
                    onPressed: () {
                      print("Forgot Btn Clicked!!");
                    },
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(Icons.lock, color: lockDownColor),
                        SizedBox(width: 10),
                        Text(
                          forgetPass,
                          style: TextStyle(
                              fontFamily: mainFaFontFamily,
                              color: forgetOptionColor),
                          textAlign: TextAlign.right,
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          BottomButton(text: finalLoginText, ontapped: navigatedToDashboard),
    );
  }
}
