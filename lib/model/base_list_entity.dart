import 'package:ttm/model/model_factory.dart';

class BaseListEntity<T> {
  List<T?>? data;
  BaseListEntity({this.data});

  factory BaseListEntity.fromJson(json) {
    List<T?>? lData = <T>[];
    if (json != null) {
      for (var v in (json["data"] as List)) {
        lData.add(ModelFactory.generateModel<T>(v));
      }
    }
    return BaseListEntity(
      data: lData,
    );
  }
}
