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
    if (statusCode == 500) {
      return AppExceptionMessages.serverSide;
    }

    return AppExceptionMessages.unknown;
  }
}
