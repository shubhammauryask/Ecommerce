import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce/Data/Models/card/card_item_model.dart';

import '../../Core/api.dart';
import '../Models/category_model/category_model.dart';

class CardRepository {
  // It take data from api and put data in the model

  final _api = Api();

  Future<List<CardItemModel>> fetchCardForUser(String userId) async {
    try {
      Response response = await _api.sendRequest.get("/cart/$userId");
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // So this is Success full then the we Convert row data din Model or put the data in the Model;
      return (apiResponse.data as List<dynamic>)
          .map((json) => CardItemModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<CardItemModel>> addToCard(
      CardItemModel cardItem, String userId) async {
    try {
      Map<String, dynamic> data = cardItem.toJson();
      data["user"] = userId;
      Response response =
          await _api.sendRequest.post("/cart", data: jsonEncode(data));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // So this is Success full then the we Convert row data din Model or put the data in the Model;
      return (apiResponse.data as List<dynamic>)
          .map((json) => CardItemModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<CardItemModel>> removeToCard(
      String productId, String userId) async {
    try {
      Map<String, dynamic> data = {
        'product':productId,
        'user':userId
      };
      Response response =
      await _api.sendRequest.delete("/cart", data: jsonEncode(data));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // So this is Success full then the we Convert row data din Model or put the data in the Model;
      return (apiResponse.data as List<dynamic>)
          .map((json) => CardItemModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }
}
