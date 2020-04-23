import 'dart:convert';
import 'dart:io';

import 'package:covidtracker/src/data/network/lib/handler/web_request_builder.dart';
import 'package:covidtracker/src/data/network/lib/stack/network_stack.dart';
import 'package:covidtracker/src/data/network/lib/stack/network_stack_response.dart';
import 'package:dio/dio.dart';

class DioStack implements INetworkStack {
  WebRequestBuilder mBuilder;

  DioStack(this.mBuilder);

  @override
  Future<NetworkStackResponse> getResult() async {
    switch (mBuilder.requestMethod) {
      case RequestMethod.GET:
        return GET();
      case RequestMethod.PUT:
      case RequestMethod.DELETE:
      case RequestMethod.POST:
        return POST_PUT_DELETE();
      default:
        return GET();
    }
  }

  Future<NetworkStackResponse> GET() async {
    NetworkStackResponse stackResponse;

    try {
      Response<List<int>> response;
      Dio dio = new Dio();

      if (mBuilder.debug) {
        dio.interceptors.add(LogInterceptor(responseBody: false));
      }

      response = await dio.get(mBuilder.url,
          options: Options(
              headers: mBuilder.header, responseType: ResponseType.bytes),
          queryParameters: mBuilder.requestParams);

      Map<String, String> headers = new Map();
      response.headers.forEach((key, value) => headers[key] = value.join(","));

      String responseText = Utf8Decoder().convert(response.data);
      //String responseText = response.data;

      stackResponse = NetworkStackResponse(
        response.statusCode,
        responseText,
        headers: headers,
      );
    } on SocketException catch (_) {
      print('not connected');
      stackResponse = getNetworkErrorResponse();
    } on DioError catch (e) {
      stackResponse = parseDioError(e);
    }

    return stackResponse;
  }

  Future<NetworkStackResponse> POST_PUT_DELETE() async {
    NetworkStackResponse stackResponse;
    try {
      Response response;
      Dio dio = new Dio();

      if (mBuilder.debug) {
        dio.interceptors.add(LogInterceptor(responseBody: false));
      }

      if (mBuilder.requestParams != null) {
        FormData formData = new FormData.fromMap(mBuilder.requestParams);
        mBuilder.header["Content-Type"] = "application/x-www-form-urlencoded";
        response = await dio.post(mBuilder.url,
            options: Options(
                headers: mBuilder.header, responseType: ResponseType.bytes),
            data: formData);
      } else if (mBuilder.requestBody != null) {
        response = await dio.post(mBuilder.url,
            options: Options(
                headers: mBuilder.header, responseType: ResponseType.bytes),
            data: mBuilder.requestBody);
      }

      Map<String, String> headers = new Map();
      response.headers.forEach((key, value) => headers[key] = value.join(","));

      String responseText = Utf8Decoder().convert(response.data);

      if (mBuilder.debug) {
        print("Response:" + responseText);
      }

      stackResponse = NetworkStackResponse(
        response.statusCode,
        responseText,
        headers: headers,
      );
    } on SocketException catch (_) {
      stackResponse = getNetworkErrorResponse();
      print('not connected');
    } on DioError catch (e) {
      stackResponse = parseDioError(e);
    }

    return stackResponse;
  }

  String mapToQueryString(Map<String, dynamic> params) {
    String query = "";
    for (var key in params.keys) {
      if (query != "") {
        query += "&";
      }
      query += key + "=" + params[key].toString();
    }
    return query;
  }

  NetworkStackResponse getNetworkErrorResponse() {
    return NetworkStackResponse(
      10,
      "Failed to connect",
    );
  }

  NetworkStackResponse parseDioError(DioError error) {
    print('dio error.type' + error.error.toString());
    if (error.type == DioErrorType.RESPONSE) {
      return NetworkStackResponse(error.response.statusCode,
          (error.message ?? "") + (error.toString() ?? "").toString());
    } else if (error.type == DioErrorType.CONNECT_TIMEOUT ||
        error.type == DioErrorType.SEND_TIMEOUT) {
      return NetworkStackResponse(
        10,
        "Failed to connect",
      );
    } else if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
      return NetworkStackResponse(
        11,
        "Server is not responding",
      );
    } else {
      return NetworkStackResponse(
        0,
        error.error.toString(),
      );
    }
  }
}
