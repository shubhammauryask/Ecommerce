import 'package:ecommerce/Data/Models/user/user_model.dart';
import 'package:ecommerce/Logic/Cubit/User_Cubit/User_state.dart';
import 'package:ecommerce/Logic/Cubit/User_Cubit/user_Cubit.dart';
import 'package:ecommerce/Presentation/screens/Widget/gap_widget.dart';
import 'package:ecommerce/Presentation/screens/Widget/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themeUI/ui.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = "edit_profile";

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
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
              return editProfile(state.userModel);
            }
            return const Center(
              child: Text("An error occurred"),
            );
          },
        ),
      ),
    );
  }

  Widget editProfile(UserModel userModel) {
    return ListView(
      padding: EdgeInsets.all(8),
      children: [
        Text(
          "Personal Detail",
          style: TextStyles.textMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        PrimaryTextField(
          initialValue: userModel.fullName,
          labelText: "FullName",
          onChange: (value) {
            userModel.fullName = value;
          },
          controller: null,
        ),
        const GapWidget(),
        PrimaryTextField(
          initialValue: userModel.phoneNumber,
          onChange: (value) {
            userModel.phoneNumber = value;
          },
          labelText: "Phone Numenber",
          controller: null,
        ),
        const GapWidget(),
        Text(
          "Address",
          style: TextStyles.textMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        PrimaryTextField(
          initialValue: userModel.address,
          onChange: (value) {
            userModel.address = value;
          },
          labelText: "Address",
          controller: null,
        ),
        const GapWidget(),
        PrimaryTextField(
          initialValue: userModel.city,
          onChange: (value) {
            userModel.city = value;
          },
          labelText: "City",
          controller: null,
        ),
        const GapWidget(),
        PrimaryTextField(
          initialValue: userModel.state,
          onChange: (value) {
            userModel.state = value;
          },
          labelText: "State",
          controller: null,
        ),
        const GapWidget(
          size: 30,
        ),
        ElevatedButton(
          onPressed: () async {
            bool success = await BlocProvider.of<UserCubit>(context)
                .updateFunction(userModel);
            if(success == true){
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(8),
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          child: Text(
            "Save",
            style: TextStyles.textMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
