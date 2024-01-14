class Endpoint {
  String path;
  Map<String, dynamic>? queryParameters;

  Endpoint({
    required this.path,
    this.queryParameters,
  });
}
