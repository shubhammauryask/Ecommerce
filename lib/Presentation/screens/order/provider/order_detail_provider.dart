import 'package:flutter/cupertino.dart';

class OrderDetailProvider with ChangeNotifier{
  String?  paymentMethod = "pay-on-delivery";
  void changePaymentMethod(String? value){
    paymentMethod = value;
    notifyListeners();
  }
}