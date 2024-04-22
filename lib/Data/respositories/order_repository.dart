import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ecommerce/Data/Models/card/card_item_model.dart';
import 'package:ecommerce/Data/Models/order/order_model.dart';
import '../../Core/api.dart';
class OrderRepository{
  final _api = Api();

  Future<List<OrderModel>> fetchOrderForUser(String userId) async {
    try {
      Response response = await _api.sendRequest.get("/order/$userId");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // So this is Success full then the we Convert row data din Model or put the data in the Model;
      return (apiResponse.data as List<dynamic>)
          .map((json) => OrderModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<OrderModel> createOrder(
      OrderModel orderModel) async {
    try {
      Response response =
      await _api.sendRequest.post("/order", data: jsonEncode(orderModel.toJson()));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return OrderModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }


}
