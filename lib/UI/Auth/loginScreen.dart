import 'package:ecommerce_app_youtube/Provider/appProvider.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? _phoneNumberFieldController;
  OtpFieldController otpController = OtpFieldController();

  FocusNode? _phoneFocusNode;
  bool showOtpBoxes = false, loader = false;
  String error = "";

  @override
  void initState() {
    _phoneNumberFieldController = TextEditingController();
    _phoneFocusNode = FocusNode();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showOtpBoxes = Provider.of<AppProvider>(context).otpSent;
    if (showOtpBoxes) {
      loader = false;
    }
  }

  @override
  void dispose() {
    _phoneFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: _height,
        width: _width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Athens",
              style: TextStyle(
                fontSize: _height * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: _height * 0.05),
            // phone number container
            showOtpBoxes == false
                ? Container(
                    height: _height * 0.4,
                    width: _width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 12,
                          color: Color.fromRGBO(0, 0, 0, 0.16),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Enter Mobile Number to Continue",
                          style: TextStyle(
                            fontSize: _height * 0.02,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        error == ""
                            ? SizedBox()
                            : Text(
                                "please enter a valid number",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: _height * 0.015,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        Container(
                          width: _width * 0.7,
                          height: _height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          alignment: Alignment.center,
                          child: TextField(
                            autofocus: true,
                            // maxLength: 10,
                            focusNode: _phoneFocusNode,
                            controller: _phoneNumberFieldController,
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              if (value.length > 10) {
                                error = "Phone number is not valid";
                                setState(() {});
                              }
                            },
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            cursorColor: Colors.white,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                              prefixText: '+91',
                              prefixStyle: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 15,
                              ),
                              hintText: "Enter Mobile Number",
                              hintStyle: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 15,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            var ph = _phoneNumberFieldController!.text;
                            if (ph.length == 10) {
                              Provider.of<AppProvider>(context, listen: false).setPhonenumber(ph);
                              Provider.of<AppProvider>(context, listen: false).otpAuth(ph, context);
                              loader = true;
                              setState(() {});
                            } else {
                              error = "Please enter a valid phone number";
                            }
                          },
                          child: Container(
                            width: _width * 0.35,
                            height: _height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff3E66FB),
                            ),
                            alignment: Alignment.center,
                            child: loader
                                ? Container(height: 20, child: CircularProgressIndicator(color: Colors.white))
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Continue",
                                        style: TextStyle(
                                          fontSize: _height * 0.02,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Icon(
                                        Icons.navigate_next_outlined,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  )
                // otp container
                : Container(
                    height: _height * 0.4,
                    width: _width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 12,
                          color: Color.fromRGBO(0, 0, 0, 0.16),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Enter the OTP sent to this number +91${Provider.of<AppProvider>(context).getPhoneNumber}",
                          style: TextStyle(
                            fontSize: _height * 0.017,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        OTPTextField(
                            controller: otpController,
                            length: 6,
                            width: MediaQuery.of(context).size.width * 0.73,
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldWidth: 45,
                            fieldStyle: FieldStyle.box,
                            outlineBorderRadius: 15,
                            style: TextStyle(fontSize: 17),
                            onChanged: (pin) {
                              // print("Changed: " + pin);
                            },
                            onCompleted: (pin) {
                              loader = true;
                              setState(() {});
                              Provider.of<AppProvider>(context, listen: false).manualOtpVerification(context, pin);

                              // print("Completed: " + pin);
                            }),
                        GestureDetector(
                          onTap: () {
                            loader = false;
                            showOtpBoxes = false;
                            Provider.of<AppProvider>(context, listen: false).otpSent = false;
                            setState(() {});
                          },
                          child: Container(
                            width: _width * 0.35,
                            height: _height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff3E66FB),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Try Again",
                                  style: TextStyle(
                                    fontSize: _height * 0.02,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.emergency,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            SizedBox(height: _height * 0.1),
          ],
        ),
      ),
    );
  }
}
