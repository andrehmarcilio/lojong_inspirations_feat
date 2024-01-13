class Endpoint {
  String path;
  Map<String, String>? queryParameters;

  Endpoint({
    required this.path,
    this.queryParameters,
  });
}
