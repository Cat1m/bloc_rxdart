// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:dio/dio.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleError(DioException error) {
    log('Handling DioException: ${error.type}');
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            return DataSource.BAD_REQUEST.getFailure();
          case 401:
            return DataSource.UNAUTHORISED.getFailure();
          case 403:
            return DataSource.FORBIDDEN.getFailure();
          case 404:
            return DataSource.NOT_FOUND.getFailure();
          case 500:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }
      case DioExceptionType.cancel:
        return DataSource.CANCEL.getFailure();
      default:
        return DataSource.DEFAULT.getFailure();
    }
  }
}

class Failure {
  int code;
  String message;

  Failure(this.code, this.message);
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(400, 'Bad request');
      case DataSource.FORBIDDEN:
        return Failure(403, 'Forbidden');
      case DataSource.UNAUTHORISED:
        return Failure(401, 'Unauthorised');
      case DataSource.NOT_FOUND:
        return Failure(404, 'Not found');
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(500, 'Internal server error');
      case DataSource.CONNECT_TIMEOUT:
        return Failure(-1, 'Connect timeout');
      case DataSource.CANCEL:
        return Failure(-2, 'Request cancelled');
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(-3, 'Receive timeout');
      case DataSource.SEND_TIMEOUT:
        return Failure(-4, 'Send timeout');
      case DataSource.CACHE_ERROR:
        return Failure(-5, 'Cache error');
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(-6, 'No internet connection');
      case DataSource.DEFAULT:
        return Failure(-7, 'Something went wrong');
      default:
        return Failure(-7, 'Something went wrong');
    }
  }
}
