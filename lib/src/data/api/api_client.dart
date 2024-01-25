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
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          'SYSHAB-KEYS': ApiEndPoint.apiKey,
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
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError;

    if (isRTO && attemptIndex < ApiEndPoint.baseAuthorityList.length - 1) {
      var lastBaseAuthority = ApiEndPoint.baseAuthority;
      ApiEndPoint.nextAuthorityIndex();
      var newBaseAuthority = ApiEndPoint.baseAuthority;
      return lastUrl.replaceAll(lastBaseAuthority, newBaseAuthority);
    }

    return null;
  }

  Future<String> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headerParameters,
    int attemptIndex = 0,
    Options? options,
    // CancelToken? cancelToken,
    // ProgressCallback? onReceiveProgress,
  }) async {
    try {
      options ??= Options();
      options.headers = headerParameters;

      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
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

  Future<String> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headerParameters,
    int attemptIndex = 0,
    Options? options,
    // CancelToken? cancelToken,
    // ProgressCallback? onSendProgress,
    // ProgressCallback? onReceiveProgress,
  }) async {
    try {
      FormData? newData;
      if (data is Map) {
        newData = await data.convertAsFormData();
      }

      options ??= Options();
      options.headers = headerParameters;

      final Response response = await _dio.post(
        url,
        data: newData,
        queryParameters: queryParameters,
        options: options,
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

  Future<String> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headerParameters,
    int attemptIndex = 0,
    Options? options,
    // CancelToken? cancelToken,
    // ProgressCallback? onSendProgress,
    // ProgressCallback? onReceiveProgress,
  }) async {
    try {
      options ??= Options();
      options.headers = headerParameters;

      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
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

  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headerParameters,
    int attemptIndex = 0,
    Options? options,
    // CancelToken? cancelToken,
    // ProgressCallback? onSendProgress,
    // ProgressCallback? onReceiveProgress,
  }) async {
    try {
      options ??= Options();
      options.headers = headerParameters;

      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
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
    //List<MapEntry<String, MultipartFile>> files = [];
    for (var i = 0; i < keyList.length; i++) {
      var key = keyList[i];
      var value = this[key];
      if (value is FileUploadData) {
        value = await MultipartFile.fromFile(value.filePath,
            filename: value.fileName);
      } else if (value is List<FileUploadData>) {
        int length = value.length;
        final fileList = <MultipartFile>[];
        for (var j = 0; j < length; j++) {
          final FileUploadData fileData = value[j];
          fileList.add(await MultipartFile.fromFile(fileData.filePath,
              filename: fileData.fileName));

          // files.add(MapEntry(
          //   "$key",
          //   MultipartFile.fromFileSync(fileData.filePath,
          //       filename: fileData.fileName),
          // ));
        }
        //continue;
        value = fileList;
      }
      data.putIfAbsent(key, () => value ?? "");
    }
    final formData = FormData.fromMap(data);

    // if (files.isNotEmpty) {
    //   formData.files.addAll(files);
    // }
    return formData;
  }
}
