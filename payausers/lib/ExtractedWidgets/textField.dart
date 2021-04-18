import 'package:flutter/material.dart';
import 'package:payausers/ConstFiles/initialConst.dart';

class TextFields extends StatelessWidget {
  TextFields(
      {this.lblText,
      this.onChangeText,
      this.textFieldIcon,
      this.textInputType,
      this.validate,
      this.iconPressed,
      this.maxLen,
      this.errText,
      this.enteringEditing,
      this.readOnly,
      this.initValue});

  final String lblText;
  final Function onChangeText;
  final IconData textFieldIcon;
  final bool textInputType;
  final Function validate;
  final Function iconPressed;
  final int maxLen;
  final dynamic errText;
  final Function enteringEditing;
  final bool readOnly;
  final String initValue;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          readOnly: readOnly,
          keyboardType: TextInputType.emailAddress,
          initialValue: initValue,
          maxLength: maxLen,
          validator: validate,
          obscureText: textInputType,
          textAlign: TextAlign.center,
          cursorColor: mainCTA,
          decoration: InputDecoration(
            counterText: "",
            errorText: errText,
            errorStyle: TextStyle(fontFamily: mainFaFontFamily),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: mainCTA,
                width: 2,
              ),
            ),
            fillColor: mainCTA,
            labelText: lblText,
            //TODO Fill this section for extract my custom Widget
            labelStyle: TextStyle(fontFamily: mainFaFontFamily, color: mainCTA),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            suffixIcon: FlatButton(
              minWidth: 10,
              onPressed: iconPressed,
              child: Icon(
                textFieldIcon,
                color: mainCTA,
              ),
            ),
          ),
          onChanged: onChangeText,
          onEditingComplete: enteringEditing,
        ),
      ),
    );
  }
}
