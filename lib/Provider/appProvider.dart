import 'package:ecommerce_app_youtube/UI/General/homepageScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String? phoneNumber = "";
  String get getPhoneNumber => phoneNumber!;

  setPhonenumber(String ph) {
    phoneNumber = ph;
    notifyListeners();
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool otpSent = false, verificationFailed = false;
  String verificationError = "", verificationId = "";

  Future otpAuth(String phonenumber, BuildContext context) async {
    print("otp auth called $phoneNumber ");
    verificationFailed = false;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${phonenumber}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        // print("verificationCompleted");
        // called if verification is done
        var data = await firebaseAuth.signInWithCredential(credential);
        // print("data ${data.user!.uid}");

        if (data.user == null) {
          verificationFailed = true;
          notifyListeners();
        } else {
          var uid = data.user!.uid;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePageScreen()),
          );
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        verificationFailed = true;
        // verificationError = e.toString();
      },
      codeSent: (String verificationid, int? resendToken) {
        verificationId = verificationid;
        otpSent = true;
        print("otp sent true");
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        verificationId = verificationId;

        // Create a PhoneAuthCredential with the code
      },
    );
  }

  Future manualOtpVerification(BuildContext context, String otp) async {
    var credential = await PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
    var data = await firebaseAuth.signInWithCredential(credential);
    if (data.user == null) {
      verificationFailed = true;
      notifyListeners();
    } else {
      var uid = data.user!.uid;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePageScreen()),
      );
    }
  }
}
