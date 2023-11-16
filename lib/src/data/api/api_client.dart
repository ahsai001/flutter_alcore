import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_alcore/src/data/api/api_endpoint.dart';
import 'package:flutter_alcore/src/data/api/api_exception.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  final _dio = Dio();

  Future<void> initialize() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final options = BaseOptions(
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
        sendTimeout: const Duration(milliseconds: 10000),
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          'X-KEYS': ApiEndPoint.apiKey,
          'x-platform': Platform.operatingSystem,
          'x-appname': packageInfo.appName,
          'x-packagename': packageInfo.packageName,
          'x-version': packageInfo.version,
          'x-buildnumber': packageInfo.buildNumber
        },
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.json);
    _dio.options = options;
    if (kDebugMode) {
      _dio.interceptors
          .add(PrettyDioLogger(requestHeader: true, requestBody: true));
    }
  }

  String? newUrlForHandleRTO(DioException e, int attemptIndex, String lastUrl) {
    var isRTO = e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout;

    if (isRTO && attemptIndex < ApiEndPoint.baseAuthorityList.length - 1) {
      var lastBaseAuthority = ApiEndPoint.baseAuthority;
      ApiEndPoint.nextAuthorityIndex();
      var newBaseAuthority = ApiEndPoint.baseAuthority;
      return lastUrl.replaceAll(lastBaseAuthority, newBaseAuthority);
    }

    return null;
  }

  Future<String> get(String url,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headerParameters,
      int attemptIndex = 0
      // Options? options,
      // CancelToken? cancelToken,
      // ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headerParameters),
        // cancelToken: cancelToken,
        // onReceiveProgress: onReceiveProgress,
      );
      return response.toString();
    } on DioException catch (e) {
      final errorMessage = ApiExceptions.fromDioError(e).message;
      var newUrl = newUrlForHandleRTO(e, attemptIndex, url);
      if (newUrl != null) {
        return get(newUrl,
            queryParameters: queryParameters,
            headerParameters: headerParameters,
            attemptIndex: attemptIndex++);
      } else {
        throw errorMessage;
      }
    }
  }

  Future<String> post(String url,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headerParameters,
      int attemptIndex = 0
      // Options? options,
      // CancelToken? cancelToken,
      // ProgressCallback? onSendProgress,
      // ProgressCallback? onReceiveProgress,
      }) async {
    try {
      if (data is Map) {
        data = await data.convertAsFormData();
      }
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headerParameters),
        // cancelToken: cancelToken,
        // onSendProgress: onSendProgress,
        // onReceiveProgress: onReceiveProgress,
      );
      return response.toString();
    } on DioException catch (e) {
      final errorMessage = ApiExceptions.fromDioError(e).message;
      var newUrl = newUrlForHandleRTO(e, attemptIndex, url);
      if (newUrl != null) {
        return post(newUrl,
            data: data,
            queryParameters: queryParameters,
            headerParameters: headerParameters,
            attemptIndex: attemptIndex++);
      } else {
        throw errorMessage;
      }
    }
  }

  Future<String> put(String url,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headerParameters,
      int attemptIndex = 0
      // Options? options,
      // CancelToken? cancelToken,
      // ProgressCallback? onSendProgress,
      // ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headerParameters),
        // cancelToken: cancelToken,
        // onSendProgress: onSendProgress,
        // onReceiveProgress: onReceiveProgress,
      );
      return response.toString();
    } on DioException catch (e) {
      final errorMessage = ApiExceptions.fromDioError(e).message;
      var newUrl = newUrlForHandleRTO(e, attemptIndex, url);
      if (newUrl != null) {
        return put(newUrl,
            data: data,
            queryParameters: queryParameters,
            headerParameters: headerParameters,
            attemptIndex: attemptIndex++);
      } else {
        throw errorMessage;
      }
    }
  }

  Future<dynamic> delete(String url,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headerParameters,
      int attemptIndex = 0
      // Options? options,
      // CancelToken? cancelToken,
      // ProgressCallback? onSendProgress,
      // ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headerParameters),
        // cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      final errorMessage = ApiExceptions.fromDioError(e).message;
      var newUrl = newUrlForHandleRTO(e, attemptIndex, url);
      if (newUrl != null) {
        return delete(newUrl,
            data: data,
            queryParameters: queryParameters,
            headerParameters: headerParameters,
            attemptIndex: attemptIndex++);
      } else {
        throw errorMessage;
      }
    }
  }
}

class FileUploadData {
  final String filePath;
  final String fileName;

  FileUploadData(this.filePath, this.fileName);
}

extension FileUploadDataMap on Map {
  Future<FormData> convertAsFormData() async {
    Map<String, dynamic> data = {};
    var keyList = keys.toList();
    for (var i = 0; i < keyList.length; i++) {
      var key = keyList[i];
      var value = this[key];
      if (value is FileUploadData) {
        value = await MultipartFile.fromFile(value.filePath,
            filename: value.fileName);
      }
      //data[key] = value;
      data.putIfAbsent(key, () => value);
    }
    return FormData.fromMap(data);
  }
}
