class HttpException {
  final int? statusCode;
  final String? message;

  HttpException({this.statusCode, this.message});

  @override
  String toString() {
    return 'ApiException: $message (status code $statusCode)';
  }
}
