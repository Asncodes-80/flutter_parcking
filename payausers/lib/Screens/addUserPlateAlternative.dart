import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payausers/Classes/AlphabetClassList.dart';
import 'package:payausers/Classes/ThemeColor.dart';
import 'package:payausers/ConstFiles/constText.dart';
import 'package:payausers/ConstFiles/initialConst.dart';
import 'package:payausers/ExtractedWidgets/dropdownMenu.dart';
import 'package:payausers/controller/addPlateController.dart';
import 'package:provider/provider.dart';

String plate0 = "";
String plate1 = "";
String plate2 = "";
String plate3 = "";
dynamic themeChange;
int _value = 0;
AlphabetList alp = AlphabetList();

class AddUserPlatAlternative extends StatefulWidget {
  @override
  _AddUserPlatAlternative createState() => _AddUserPlatAlternative();
}

class _AddUserPlatAlternative extends State<AddUserPlatAlternative> {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  void dispose() {
    plate0 = "";
    plate1 = "";
    plate2 = "";
    plate3 = "";
    _value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map navigationArg = ModalRoute.of(context).settings.arguments != null
        ? ModalRoute.of(context).settings.arguments
        : {"route": "poper"};

    print("Navigation arg ===> $navigationArg");
    final routeModalArg = navigationArg["route"];

    print(routeModalArg == "pop" ? "" : "reserveEditaion");

    themeChange = Provider.of<DarkThemeProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainCTA,
          centerTitle: true,
          title: Text(
            addUserPlate,
            style:
                TextStyle(fontFamily: mainFaFontFamily, fontSize: subTitleSize),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        yourPlateNumber,
                        style: TextStyle(
                            fontFamily: mainFaFontFamily,
                            fontSize: subTitleSize),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 70,
                // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin:
                    EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                        color:
                            themeChange.darkTheme ? Colors.white : Colors.black,
                        width: 2.8),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 2),
                          Image.asset(
                            "assets/images/iranFlag.png",
                            width: 35,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'I.R.',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'I R A N',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 70,
                      margin: EdgeInsets.only(top: 0),
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: 26,
                            fontFamily: mainFaFontFamily,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        initialValue: plate0,
                        decoration: InputDecoration(
                            counterText: "", border: InputBorder.none),
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            plate0 = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 70,
                      margin: EdgeInsets.only(top: 0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: _value,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: mainFaFontFamily,
                              color: themeChange.darkTheme
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 22),
                          items: dropdownMenu,
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                              // print(_value);
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 70,
                      margin: EdgeInsets.only(top: 0, right: 0),
                      child: TextFormField(
                        initialValue: plate2,
                        style: TextStyle(
                            fontSize: 26,
                            fontFamily: mainFaFontFamily,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            counterText: "", border: InputBorder.none),
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            plate2 = value;
                          });
                        },
                      ),
                    ),
                    VerticalDivider(
                        width: 1,
                        color:
                            themeChange.darkTheme ? Colors.white : Colors.black,
                        thickness: 3),
                    Container(
                      width: 50,
                      height: 70,
                      margin: EdgeInsets.only(top: 0, right: 10),
                      child: TextFormField(
                        initialValue: plate3,
                        style: TextStyle(
                            fontSize: 26,
                            fontFamily: mainFaFontFamily,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            counterText: "", border: InputBorder.none),
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            plate3 = value;
                          });
                        },
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textBaseline: TextBaseline.alphabetic,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      correctEntry,
                      style: TextStyle(
                        fontFamily: mainFaFontFamily,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(8.0),
            color: primarySubmitBtnColor,
            child: MaterialButton(
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                  // Define a popor for chosing between
                  //  my plates tab in dashboard and in main reserver route
                  String navigationRoutePoper =
                      routeModalArg == "pop" ? "" : "reserveEditaion";
                  sendNewUserPlate(
                    plate0,
                    alp.getAlphabet()[_value].item,
                    plate2,
                    plate3,
                    context,
                    themeChange,
                    navigationRoutePoper,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      submitPlate,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: loginBtnTxtColor,
                          fontFamily: mainFaFontFamily,
                          fontSize: btnSized,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
