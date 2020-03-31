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
  @JsonKey(name: 'LAT')
  String lat;
  @JsonKey(name: 'LNG')
  String lng;

  RoadTree({this.GUName, this.ObjectId, this.WDPTName, this.lat, this.lng});

  factory RoadTree.fromJson(Map<String, dynamic> json) => _$RoadTreeFromJson(json);

  Map<String, dynamic> toJson() => _$RoadTreeToJson(this);

}

List<RoadTree> treeList = [];