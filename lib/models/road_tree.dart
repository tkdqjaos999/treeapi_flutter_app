import 'package:json_annotation/json_annotation.dart';

part 'road_tree.g.dart';

@JsonSerializable()
class RoadTree {
  @JsonKey(name:'GU_NM')
  String GUName;
  @JsonKey(name: 'OBJECTID')
  double ObjectId;
  @JsonKey(name: 'WDPT_NM')
  String WDPTName;
  @JsonKey(name: 'X')
  String x;
  @JsonKey(name: 'Y')
  String y;

  RoadTree({this.GUName, this.ObjectId, this.WDPTName, this.x, this.y});

  factory RoadTree.fromJson(Map<String, dynamic> json) => _$RoadTreeFromJson(json);

  Map<String, dynamic> toJson() => _$RoadTreeToJson(this);

}