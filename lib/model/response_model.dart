class ResponseModel<T> {
  final int? code;
  final String? msg;
  final T? data; // JsonArray [], JsonObject {}

  ResponseModel(
    this.code,
    this.msg,
    this.data,
  );
}
