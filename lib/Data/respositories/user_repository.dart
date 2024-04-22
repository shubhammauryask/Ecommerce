import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce/Data/Models/user/user_model.dart';

import '../../Core/api.dart';

class UserRepository {
  // It take data from api and put data in the model

  final _api = Api();

  Future<UserModel> createAccount(
      {required String fullName,
      required String email,
      required String password}) async {
    try {
      Response response = await _api.sendRequest.post("/user/createAccount",
          data: jsonEncode(
              {"fullName": fullName, "email": email, "password": password}));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // So this is Success full then the we Convert row data din Model or put the data in the Model;
      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<UserModel> signIn(
      {required String email, required String password, }) async {
    try {
      Response response = await _api.sendRequest.post("/user/signIn",
          data: jsonEncode({"email": email, "password": password}));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // So this is Success full then the we Convert row data din Model or put the data in the Model;
      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<UserModel> updateUser(userModel) async {
    try {
      Response response = await _api.sendRequest.put("/user/${userModel.sId}",
          data: jsonEncode(userModel.toJson()));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // So this is Success full then the we Convert row data din Model or put the data in the Model;
      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }
}
