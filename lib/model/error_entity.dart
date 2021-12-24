class ErrorEntity<T> {
  String? code;
  String? message;
  ErrorEntity({this.code, this.message});

  factory ErrorEntity.formCode(statusCode) {
    String? msg;
    String? errCode = statusCode.toString();
    return ErrorEntity(code: errCode, message: "未知错误");
  }
}
