import '../../common/models/app_exception_messages.dart';

class HttpException {
  final int? statusCode;
  final String? message;

  HttpException({this.statusCode, this.message});

  @override
  String toString() {
    return 'ApiException: $message (status code $statusCode)';
  }

  AppExceptionMessages get exceptionMessage {
    switch (statusCode) {
      case null:
        return AppExceptionMessages.noConnection;
      case >= 500:
        return AppExceptionMessages.serverSide;
      default:
        return AppExceptionMessages.unknown;
    }
  }
}
