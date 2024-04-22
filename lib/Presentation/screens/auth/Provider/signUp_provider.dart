import 'dart:async';
import 'dart:math';

import 'package:ecommerce/Logic/Cubit/User_Cubit/User_state.dart';
import 'package:ecommerce/Logic/Cubit/User_Cubit/user_Cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpProvider with ChangeNotifier {
  final BuildContext context;

  SignUpProvider(this.context) {
    _listenToUserCubit();
  }

  bool isLoading = false;
  String error = "";
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cPasswordController = TextEditingController();
  var fullNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  StreamSubscription? _userSubscription;

  void _listenToUserCubit() {
    print('Listening the user State');
    BlocProvider.of<UserCubit>(context).stream.listen((userState) {
      if (userState is UserLoadingState) {
        isLoading = true;
        notifyListeners();
      } else if (userState is UserErrorState) {
        isLoading = false;
        error = userState.message;
        notifyListeners();
      } else {
        isLoading = false;
        error = "";
        notifyListeners();
      }
    });
  }

  void createAccount() async {
    if (!formKey.currentState!.validate()) return;
    String fullName = fullNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    BlocProvider.of<UserCubit>(context)
        .createAccount(fullName: fullName, email: email, password: password);
  } //by this createAccount (email ,fullName,password) goes to-> cubit ->repository ->Call the api then and take response -> cubit ->The we get it by listener

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
