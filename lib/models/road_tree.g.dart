// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'road_tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoadTree _$RoadTreeFromJson(Map<String, dynamic> json) {
  return RoadTree(
    GUName: json['GU_NM'] as String,
    ObjectId: (json['OBJECTID'] as num)?.toDouble(),
    WDPTName: json['WDPT_NM'] as String,
    x: json['X'] as String,
    y: json['Y'] as String,
  );
}

Map<String, dynamic> _$RoadTreeToJson(RoadTree instance) => <String, dynamic>{
      'GU_NM': instance.GUName,
      'OBJECTID': instance.ObjectId,
      'WDPT_NM': instance.WDPTName,
      'X': instance.x,
      'Y': instance.y,
    };
