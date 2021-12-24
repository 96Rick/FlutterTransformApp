import 'package:ttm/model/model_factory.dart';

class BaseEntity<T> {
  T? data;
  BaseEntity({this.data});
  factory BaseEntity.fromJson(json) {
    if (json == "" || json == null) {
      return BaseEntity();
    } else {
      return BaseEntity(
        data: ModelFactory.generateModel<T>(json["data"]),
      );
    }
  }
}
