import 'package:ecommerce/Presentation/screens/auth/Provider/signUp_provider.dart';
import 'package:ecommerce/Presentation/screens/auth/login_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../Logic/Cubit/User_Cubit/User_state.dart';
import '../../../Logic/Cubit/User_Cubit/user_Cubit.dart';
import '../../../themeUI/ui.dart';
import '../Widget/gap_widget.dart';
import '../Widget/linkTextButton_widget.dart';
import '../Widget/primaryButton_widget.dart';
import '../Widget/textformfield_widget.dart';
import '../home/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String routeName = "SignUp";
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);
    return BlocListener<UserCubit,UserState>(
      listener: (context,state){
        if(state is UserLoggedInState){
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
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
                    'Sign In',
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
                        return "Full Name is Required";
                      }
                      return null; //means no Error
                    },
                    labelText: 'Full Name',
                    controller: provider.fullNameController,
                  ),
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
                  const GapWidget(
                    size: 4,
                  ),
                  PrimaryTextField(
                    labelText: 'Confirm Password',
                    controller: provider.cPasswordController,
                    obscureText: true,
                    validator: (value){
                      if(value == null|| value.trim().isEmpty){
                        return "Confirm your Password";
                      }
                      if(value.trim() != provider.passwordController.text.trim()){
                        return "Password do not match!";
                      }
                      return null; // means no Error
                    },
                  ),
                  GapWidget(
                    size: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: PrimaryButton(
                      text: (provider.isLoading) ? "..." : 'Sign In',
                      onPressed: provider.createAccount,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have a Account?',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      LinkButton(
                        text: 'Log In',
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
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
