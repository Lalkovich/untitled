import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        switch (statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
          default:
            throw DioException(
              requestOptions: err.requestOptions,
              response: err.response,
              type: DioExceptionType.badResponse,
              error: 'HTTP $statusCode: ${err.response?.statusMessage}',
            );
        }
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        throw NoInternetConnectionException(err.requestOptions);
      case DioExceptionType.badCertificate:
        throw BadCertificateException(err.requestOptions);
      case DioExceptionType.connectionError:
        throw ConnectionErrorException(err.requestOptions);
    }

    return handler.next(err);
  }
}

  class BadRequestException implements DioException {
  final RequestOptions requestOptions;

  BadRequestException(this.requestOptions);

  @override
  DioException copyWith({
  RequestOptions? requestOptions,
  Response? response,
  DioExceptionType? type,
  Object? error,
  StackTrace? stackTrace,
  String? message,
  }) {
  return BadRequestException(
  requestOptions ?? this.requestOptions,
  );
  }

  @override
  Object? get error => null;

  @override
  String? get message => 'Invalid request';

  @override
  Response? get response => null;

  @override
  StackTrace get stackTrace => StackTrace.empty;

  @override
  DioExceptionType get type => DioExceptionType.badResponse;

  @override
  String toString() {
  return 'Invalid request';
  }
}

class InternalServerErrorException implements DioException {
  final RequestOptions requestOptions;

  InternalServerErrorException(this.requestOptions);

  @override
  DioException copyWith({
    RequestOptions? requestOptions,
    Response? response,
    DioExceptionType? type,
    Object? error,
    StackTrace? stackTrace,
    String? message,
  }) {
    return InternalServerErrorException(
      requestOptions ?? this.requestOptions,
    );
  }

  @override
  Object? get error => null;

  @override
  String? get message => 'Unknown error occurred, please try again later.';

  @override
  Response? get response => null;

  @override
  StackTrace get stackTrace => StackTrace.empty;

  @override
  DioExceptionType get type => DioExceptionType.badResponse;

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException implements DioException {
  final RequestOptions requestOptions;

  ConflictException(this.requestOptions);

  @override
  DioException copyWith({
    RequestOptions? requestOptions,
    Response? response,
    DioExceptionType? type,
    Object? error,
    StackTrace? stackTrace,
    String? message,
  }) {
    return ConflictException(
      requestOptions ?? this.requestOptions,
    );
  }

  @override
  Object? get error => null;

  @override
  String? get message => 'Conflict occurred';

  @override
  Response? get response => null;

  @override
  StackTrace get stackTrace => StackTrace.empty;

  @override
  DioExceptionType get type => DioExceptionType.badResponse;

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException implements DioException {
  final RequestOptions requestOptions;

  UnauthorizedException(this.requestOptions);

  @override
  DioException copyWith({
    RequestOptions? requestOptions,
    Response? response,
    DioExceptionType? type,
    Object? error,
    StackTrace? stackTrace,
    String? message,
  }) {
    return UnauthorizedException(
      requestOptions ?? this.requestOptions,
    );
  }

  @override
  Object? get error => null;

  @override
  String? get message => 'Access denied';

  @override
  Response? get response => null;

  @override
  StackTrace get stackTrace => StackTrace.empty;

  @override
  DioExceptionType get type => DioExceptionType.badResponse;

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException implements DioException {
  final RequestOptions requestOptions;

  NotFoundException(this.requestOptions);

  @override
  DioException copyWith({
    RequestOptions? requestOptions,
    Response? response,
    DioExceptionType? type,
    Object? error,
    StackTrace? stackTrace,
    String? message,
  }) {
    return NotFoundException(
      requestOptions ?? this.requestOptions,
    );
  }

  @override
  Object? get error => null;

  @override
  String? get message => 'The requested information could not be found';

  @override
  Response? get response => null;

  @override
  StackTrace get stackTrace => StackTrace.empty;

  @override
  DioExceptionType get type => DioExceptionType.badResponse;

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException implements DioException {
  final RequestOptions requestOptions;

  NoInternetConnectionException(this.requestOptions);

  @override
  DioException copyWith({
    RequestOptions? requestOptions,
    Response? response,
    DioExceptionType? type,
    Object? error,
    StackTrace? stackTrace,
    String? message,
  }) {
    return NoInternetConnectionException(
      requestOptions ?? this.requestOptions,
    );
  }

  @override
  Object? get error => null;

  @override
  String? get message => 'No internet connection detected, please try again.';

  @override
  Response? get response => null;

  @override
  StackTrace get stackTrace => StackTrace.empty;

  @override
  DioExceptionType get type => DioExceptionType.badResponse;

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException implements DioException {
  final RequestOptions requestOptions;

  DeadlineExceededException(this.requestOptions);

  @override
  DioException copyWith({
    RequestOptions? requestOptions,
    Response? response,
    DioExceptionType? type,
    Object? error,
    StackTrace? stackTrace,
    String? message,
  }) {
    return DeadlineExceededException(
      requestOptions ?? this.requestOptions,
    );
  }

  @override
  Object? get error => null;

  @override
  String? get message => 'The connection has timed out, please try again.';

  @override
  Response? get response => null;

  @override
  StackTrace get stackTrace => StackTrace.empty;

  @override
  DioExceptionType get type => DioExceptionType.badResponse;

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

class BadCertificateException implements DioException {
  final RequestOptions requestOptions;

  BadCertificateException(this.requestOptions);

  @override
  DioException copyWith({
    RequestOptions? requestOptions,
    Response? response,
    DioExceptionType? type,
    Object? error,
    StackTrace? stackTrace,
    String? message,
  }) {
    return BadCertificateException(
      requestOptions ?? this.requestOptions,
    );
  }

  @override
  Object? get error => null;

  @override
  String? get message => 'SSL certificate validation failed';

  @override
  Response? get response => null;

  @override
  StackTrace get stackTrace => StackTrace.empty;

  @override
  DioExceptionType get type => DioExceptionType.badResponse;

  @override
  String toString() {
    return 'SSL certificate validation failed';
  }
}

class ConnectionErrorException implements DioException {
  final RequestOptions requestOptions;

  ConnectionErrorException(this.requestOptions);

  @override
  DioException copyWith({
    RequestOptions? requestOptions,
    Response? response,
    DioExceptionType? type,
    Object? error,
    StackTrace? stackTrace,
    String? message,
  }) {
    return ConnectionErrorException(
      requestOptions ?? this.requestOptions,
    );
  }

  @override
  Object? get error => null;

  @override
  String? get message => 'Unable to establish a connection';

  @override
  Response? get response => null;

  @override
  StackTrace get stackTrace => StackTrace.empty;

  @override
  DioExceptionType get type => DioExceptionType.badResponse;

  @override
  String toString() {
    return 'Unable to establish a connection';
  }
}