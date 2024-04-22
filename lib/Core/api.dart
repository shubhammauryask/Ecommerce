import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String BASE_URL = "https://e-commerce-backend-d62g.onrender.com/api";
const Map<String, dynamic> DEFULT_HEADERS = {
  'Content-Type': 'application/json'
};
class Api {
  final Dio _dio = Dio();
  Api() {
    _dio.options.baseUrl = BASE_URL; // we set the a part of url to dio
    _dio.options.headers = DEFULT_HEADERS;
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.interceptors.add(PrettyDioLogger(
        //using interceptors PrettyDioLogger
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true // print or log this data when we run
        ));
  }
  // Making getar
  Dio get sendRequest => _dio;
}

class ApiResponse {
  bool success;
  dynamic data;
  String? message;
  ApiResponse(
      {required this.success, required this.data, required this.message});
  factory ApiResponse.fromResponse(Response response) {
    final data = response.data as Map<String,
        dynamic>; //with dio we  get  always in json decoded version
    return ApiResponse(
        success: data["success"],
        data: data["data"],
        message: data["message"]??"Unexpected Error"
    );
  }
}
