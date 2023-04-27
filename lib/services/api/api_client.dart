import 'package:dio/dio.dart';
import 'package:buddies/models/interest.dart';
import 'package:buddies/services/api/custom_exception.dart';
import 'package:buddies/services/api/api_endpoints.dart';

var authUserToken = '';
var userId = 0;
var interestsLoaded = false;

class ApiClient {
  var timeOutMiliSec = 10000;
  bool setTimeOut = true;
  final baseUrl = ApiEndpoints.baseUrl;

  Future<Map<String, dynamic>> httpPostRequest(
      String url, Map<String, dynamic>? userData) async {
    try {
      var dio = Dio();
      if (setTimeOut) {
        dio.options.connectTimeout = timeOutMiliSec;
      }
      Response response = await dio.post(baseUrl + url, //ENDPONT URL
          data: userData, //REQUEST BODY
          options: Options(headers: _header()));
      //returns the successful json object
      return _response(response);
    } on DioError catch (e) {
      //returns the error object if there is
      return errorHandler(e);
    }
  }

  Future<Map<String, dynamic>> httpGetRequest(String url) async {
    try {
      var dio = Dio();
      if (setTimeOut) {
        dio.options.connectTimeout = timeOutMiliSec;
      }

      Response response = await dio.get(baseUrl + url, //ENDPONT URL
          options: Options(headers: _header()));
      //returns the successful json object
      return _response(response);
    } on DioError catch (e) {
      //returns the error object if there is
      return errorHandler(e);
    }
  }

  Future<List<Interest>> getInterests({reload = false}) async {
    if (interestsLoaded && !reload) {
      return interests;
    }
    var response = await ApiClient().httpGetRequest(ApiEndpoints.interests);
    interestsLoaded = true;
    return interests = (response['data'] as List<dynamic>?)
            ?.map((e) => Interest.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }

  _header() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $authUserToken',
    };
  }

  Map<String, dynamic> _response(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        return response.data;
      case 401:
        throw UnauthorisedException();
      case 422:
        throw ValidationException('Request error', response);
      default:
        return {"messge": "Unable to complete this request"};
    }
  }

  errorHandler(e) {
    if (e is DioError) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        throw AuthTimeOutException();
      }

      if (e.response == null) {
        throw AuthNoInternetException();
      }

      return _response(e.response!);
    } else {}
  }
}
