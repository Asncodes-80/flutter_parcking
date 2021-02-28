import 'package:flutter/material.dart';
import 'package:securityapp/widgets/textField.dart';
import 'package:sizer/sizer.dart';

class MainProfile extends StatelessWidget {
  const MainProfile({
    this.avatarView,
    this.avatarPressed,
    this.userEmail,
    this.onChangeEmail,
  });

  final avatarView;
  final Function avatarPressed;
  final userEmail;
  final onChangeEmail;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.0.h),
          CircleAvatar(
            radius: 18.0.w,
            backgroundImage: avatarView != null
                ? FileImage(avatarView)
                : AssetImage("assets/images/isgpp_avatar_placeholder.png"),
            child: Container(
              margin: EdgeInsets.only(top: 90, left: 80),
              child: ClipOval(
                child: Material(
                  color: Colors.blue, // button color
                  child: InkWell(
                    splashColor: Colors.black, // inkwell color
                    child: SizedBox(
                        width: 46,
                        height: 46,
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                        )),
                    onTap: avatarPressed,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0.h),
          TextFields(
              initValue: userEmail,
              keyType: TextInputType.emailAddress,
              lblText: "ایمیل خود را وارد کنید",
              textFieldIcon: Icons.account_circle,
              textInputType: false,
              readOnly: false,
              onChangeText: onChangeEmail),
        ],
      ),
    );
  }
}
