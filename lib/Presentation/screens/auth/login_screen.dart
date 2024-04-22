import 'package:ecommerce/Logic/Cubit/User_Cubit/User_state.dart';
import 'package:ecommerce/Logic/Cubit/User_Cubit/user_Cubit.dart';
import 'package:ecommerce/Presentation/screens/Widget/gap_widget.dart';
import 'package:ecommerce/Presentation/screens/Widget/linkTextButton_widget.dart';
import 'package:ecommerce/Presentation/screens/Widget/primaryButton_widget.dart';
import 'package:ecommerce/Presentation/screens/Widget/textformfield_widget.dart';
import 'package:ecommerce/Presentation/screens/auth/Provider/login_provider.dart';
import 'package:ecommerce/Presentation/screens/auth/signUp_screen.dart';
import 'package:ecommerce/Presentation/screens/splash/splash_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../themeUI/ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "login";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

    return BlocListener<UserCubit,UserState>(
      listener: (context,state){
        if(state is UserLoggedInState){
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: provider.formKey,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Ecommerce App", style: TextStyles.headerBig),
                    ),
                  ),
                  const GapWidget(
                    size: -4,
                  ),
                  const Text(
                    'Log In',
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const GapWidget(size: -8,),
                  (provider.error != "")
                      ? Text(
                          provider.error,
                          style: const TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                  const GapWidget(
                    size: 4,
                  ),
                  PrimaryTextField(
                    validator: (value){
                      if(value == null|| value.trim().isEmpty){
                        return "Email Address is Required";
                      }
                      if(!EmailValidator.validate(value.trim())){
                        return "Invalid Email Address";
                      }
                      return null; //means no Error
                    },
                    labelText: 'Email Address',
                    controller: provider.emailController,
                  ),
                  const GapWidget(
                    size: 4,
                  ),
                  PrimaryTextField(
                    labelText: 'Password',
                    controller: provider.passwordController,
                    obscureText: true,
                    validator: (value){
                      if(value == null|| value.trim().isEmpty){
                        return "Password is Required";
                      }
                      return null; // means no Error
                    },
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LinkButton(text: 'Forgot Password?'),
                    ],
                  ),
                  GapWidget(
                    size: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: PrimaryButton(
                      backGroundColor: AppColors.primary,
                      borderRadius: 10,
                      text: (provider.isLoading) ? "..." : 'Login',
                      onPressed: provider.logIn,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Do not Have Account?',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      LinkButton(
                        text: 'SignUp',
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
