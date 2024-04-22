
import '../../../Data/Models/user/user_model.dart';
abstract class UserState {}

 class UserInitialState extends UserState{}

 class UserLoadingState extends UserState{}

 class UserLoggedInState extends UserState{
  final UserModel userModel;
  UserLoggedInState(this.userModel);
 }

 class UserLogOutState extends UserState{}

 class UserErrorState extends UserState{
  final String message ;
  UserErrorState(this.message);
 }

