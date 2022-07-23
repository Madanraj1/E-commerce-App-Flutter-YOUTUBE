import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String? phoneNumber = "";
  String get getPhoneNumber => phoneNumber!;

  setPhonenumber(String ph) {
    phoneNumber = ph;
    notifyListeners();
  }
}
