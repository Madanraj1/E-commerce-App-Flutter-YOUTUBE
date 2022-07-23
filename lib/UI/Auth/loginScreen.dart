import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? _phoneNumberFieldController;
  OtpFieldController otpController = OtpFieldController();

  FocusNode? _phoneFocusNode;
  bool otpSent = false;

  @override
  void initState() {
    _phoneNumberFieldController = TextEditingController();
    _phoneFocusNode = FocusNode();

    super.initState();
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
            otpSent == false
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
                            onChanged: (value) {},
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
                            setState(() {
                              otpSent = true;
                            });
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
                          "Enter the OTP sent to this number +911122334455",
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
                              print("Changed: " + pin);
                            },
                            onCompleted: (pin) {
                              print("Completed: " + pin);
                            }),
                        Container(
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
                                "Resend Otp",
                                style: TextStyle(
                                  fontSize: _height * 0.02,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.sms,
                                color: Colors.white,
                              )
                            ],
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
