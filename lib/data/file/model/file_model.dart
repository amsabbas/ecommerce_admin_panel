import 'package:json_annotation/json_annotation.dart';

part 'file_model.g.dart';

@JsonSerializable()
class FileModel {
  @JsonKey(name: "filename")
  final String filename;

  FileModel({
    required this.filename,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) =>
      _$FileModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileModelToJson(this);
}
