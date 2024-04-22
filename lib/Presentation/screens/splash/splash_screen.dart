import 'dart:async';

import 'package:ecommerce/Logic/Cubit/User_Cubit/User_state.dart';
import 'package:ecommerce/Logic/Cubit/User_Cubit/user_Cubit.dart';
import 'package:ecommerce/Presentation/screens/auth/login_screen.dart';
import 'package:ecommerce/Presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

  class SplashScreen extends StatefulWidget {
    const SplashScreen({super.key});
    static const String routeName = "splash";
    @override
    State<SplashScreen> createState() => _SplashScreenState();
  }

  class _SplashScreenState extends State<SplashScreen> {
    void  goToNextScreen(){
   UserState userState = BlocProvider.of<UserCubit>(context).state;
   if(userState is UserLoggedInState){
     Navigator.popUntil(context, (route) => route.isFirst);
     Navigator.pushReplacementNamed(context, HomeScreen.routeName);
   }else if(userState is UserLogOutState){
     Navigator.popUntil(context, (route) => route.isFirst);
     Navigator.pushReplacementNamed(context, LoginScreen.routeName);
   }else if(userState is UserErrorState){
     Navigator.popUntil(context, (route) => route.isFirst);
     Navigator.pushReplacementNamed(context, LoginScreen.routeName);
   }
    }
    @override
    void initState() {
    super.initState();
    Timer(Duration(milliseconds:100), () {
      goToNextScreen();
    });
    }
    @override
    Widget build(BuildContext context) {
      return BlocListener<UserCubit,UserState>(
        listener: (context,state){
          goToNextScreen();
        },
        child: Scaffold(
         body: Center(
           child: CircularProgressIndicator(),
         ),
        ),
      );
    }
  }
