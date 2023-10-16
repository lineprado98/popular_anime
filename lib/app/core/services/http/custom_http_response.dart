import 'package:dio/dio.dart';

class CustomHttpResponse {
  final int statusCode;
  final dynamic body;
  final String? messageCode;
  CustomHttpResponse(
      {required this.statusCode, required this.body, this.messageCode});

  factory CustomHttpResponse.fromSuccessDio(Response dio) {
    return CustomHttpResponse(
        statusCode: dio.statusCode ?? 500,
        messageCode: dio.statusMessage,
        body: dio.data);
  }

  factory CustomHttpResponse.fromErrorDio(DioException dioException) {
    if (dioException.response != null) {
      return CustomHttpResponse(
          statusCode: dioException.response!.statusCode ?? 500,
          body: dioException.message);
    } else {
      return CustomHttpResponse(statusCode: 500, body: dioException.message);
    }
  }
}
