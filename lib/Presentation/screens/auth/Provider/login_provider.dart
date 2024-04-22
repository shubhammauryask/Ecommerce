import 'dart:async';

import 'package:ecommerce/Logic/Cubit/User_Cubit/User_state.dart';
import 'package:ecommerce/Logic/Cubit/User_Cubit/user_Cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginProvider with ChangeNotifier {
  final BuildContext context;
  LoginProvider(this.context){
    _listenToUserCubit();
  }

  bool isLoading = false;
  String error = "";
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  StreamSubscription? _userSubscription;

  void _listenToUserCubit(){
    print('Listening the user State');
    BlocProvider.of<UserCubit>(context).stream.listen((userState) {
      if(userState is UserLoadingState){
       isLoading = true;
       notifyListeners();
      }else if(userState is UserErrorState){
        isLoading = false;
        error = userState.message;
        notifyListeners();
      }else{
        isLoading =false;
        error ="";
        notifyListeners();
      }
    });
  }

  void logIn() async {
    if(!formKey.currentState!.validate())return;
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    BlocProvider.of<UserCubit>(context).signIn(email: email, password: password);
  }

  @override
  void dispose() {
   _userSubscription?.cancel();
    super.dispose();
  }

}
