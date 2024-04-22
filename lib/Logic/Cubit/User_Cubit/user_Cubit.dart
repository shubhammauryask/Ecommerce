import 'package:ecommerce/Data/Models/user/user_model.dart';
import 'package:ecommerce/Data/respositories/user_repository.dart';
import 'package:ecommerce/Logic/Cubit/User_Cubit/User_state.dart';
import 'package:ecommerce/Logic/services/shared_Preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState()){
    _initialise();
  }// calling initialise in the constructor;
  final UserRepository _userRepository = UserRepository();


  void _initialise()async{
   final userDetail = await Preferences.fetchUserDetail();
   String? email = userDetail["email"];
   String? password = userDetail["password"];

   if(email == null || password == null){
     emit(UserLogOutState());
   }else{
     signIn(email: email, password: password);
   }

  }



  void signIn({required String email, required String password}) async {
    emit(UserLoadingState());
    try {
      UserModel userModel =
          await _userRepository.signIn(email: email, password: password);

       _emitLoggedInState(userModel: userModel, email: email, password: password);
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  Future<void> _emitLoggedInState(
      {required UserModel userModel,
      required String email,
      required String password}) async {
    await Preferences.saveUserDetails(email, password);
    emit(UserLoggedInState(userModel));
  }

  Future<void> createAccount(
      {required String fullName,
      required String email,
      required String password}) async {
    emit(UserLoadingState());
    try {
      UserModel userModel = await _userRepository.createAccount(
          fullName: fullName, email: email, password: password);

      _emitLoggedInState(userModel: userModel, email: email, password: password);
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  Future<bool> updateFunction(UserModel userModel) async {
    emit(UserLoadingState());
    try {
      UserModel updateUser = await _userRepository.updateUser(userModel);
      emit(UserLoggedInState(updateUser));
      return true;
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
      return false;
    }
  }


  void signOut()async{
     await Preferences.clear();
    emit(UserLogOutState());
  }
}
