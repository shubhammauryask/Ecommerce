import 'package:ecommerce/Data/Models/user/user_model.dart';
import 'package:ecommerce/Logic/Cubit/User_Cubit/User_state.dart';
import 'package:ecommerce/Logic/Cubit/User_Cubit/user_Cubit.dart';
import 'package:ecommerce/Presentation/screens/Widget/gap_widget.dart';
import 'package:ecommerce/Presentation/screens/order/my_order_screen.dart';
import 'package:ecommerce/Presentation/screens/user/edit_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themeUI/ui.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserErrorState) {
          return Center(
            child: Text(
              state.message,
            ),
          );
        }

        if (state is UserLoggedInState) {
          return userProfile(state.userModel);
        }
        return const Center(
          child: Text("An error occurred"),
        );
      },
    );
  }

  Widget userProfile(UserModel userModel) {
    return ListView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(16),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Shubham Maurya",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            GapWidget(
              size: -10,
            ),
            Text(
              'ram@123gmail.com',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            GapWidget(
              size: -10,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProfileScreen.routeName);
              },
              child: Text(
                'Edit Profile',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
            )
          ],
        ),
        GapWidget(),
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        GapWidget(),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, MyOrderScreen.routeName);
          },
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            CupertinoIcons.cube_box_fill,
            color: Colors.grey,
          ),
          title: Text(
            'MyOrder',
            style: TextStyles.headerLow,
          ),
        ),
        ListTile(
          onTap: () {
            BlocProvider.of<UserCubit>(context).signOut();
          },
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.red,
          ),
          title: Text(
            "Sign Out",
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
