import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake) // Jsonのシリアライズ、デシリアライズの設定、スネークケースで出力する
class Request {
  const Request({
    required this.appId,
    required this.sentence,
    this.outputType = 'hiragana',
  });

  final String appId;
  final String sentence;
  final String outputType;

  Map<String, Object?> toJson() => _$RequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Response {
  const Response({
    required this.converted,
  });
  final String converted;
  // ResponseクラスのインスタンスをJSONから生成するため、factoryコンストラクタを定義
  factory Response.fromJson(Map<String, Object?> json) =>
      _$ResponseFromJson(json);
}
