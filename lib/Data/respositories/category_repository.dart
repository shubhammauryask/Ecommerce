import 'package:dio/dio.dart';

import '../../Core/api.dart';
import '../Models/category_model/category_model.dart';

class CategoryRepository {
  // It take data from api and put data in the model

  final _api = Api();

  Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      Response response = await _api.sendRequest.get("/category");
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // So this is Success full then the we Convert row data din Model or put the data in the Model;
      return (apiResponse.data as List<dynamic>).map((json) =>
       CategoryModel.fromJson(json)).toList();
    } catch (ex) {
      rethrow;
    }
  }
}
