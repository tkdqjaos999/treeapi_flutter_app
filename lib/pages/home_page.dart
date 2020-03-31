import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:latlong/latlong.dart';
import 'package:treeapi_flutter_app/models/road_tree.dart';
import 'package:treeapi_flutter_app/pages/tree_map_page.dart';
import 'package:treeapi_flutter_app/widgets/empty_appbar.dart';
import 'package:treeapi_flutter_app/services/tree_api.dart' as api;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RoadTree> _treeData = [];
  String treeInfo = '';

  @override
  void initState() {
    loadData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: ListView(
        children: <Widget>[
          Center(child: Text('tree api')),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TreeMapPage()
                      ));
                },
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all()
                  ),
                  child: Center(child: Text('지도')),
                ),
              )
            ],
          ),
          SizedBox(height: 5,),
          ..._buildColumn()
        ],
      )
    );
  }

  Future loadData() async {
    var response = await get(api.buildUrl(api.defaultStation, 1, 5));
    String res = response.body;
    print('res >> $res');

    var json = jsonDecode(res);
    int totalCnt = json['GeoInfoOfRoadsideTreeW']['list_total_count'];
    int fetchCnt = totalCnt ~/ 1000 + 1;
    //print('total_count >> $totalCnt');
    //print('fetch_count >> $fetchCnt');

    Distance distance = Distance();
    List<RoadTree> list = [];
    for (int i = 0; i < fetchCnt; i ++) {
      var response = await get(
          api.buildUrl(api.defaultStation, 1000 * i + 1, 1000 * (i + 1)));
      String res = response.body;
      var json = jsonDecode(res);
      List<dynamic> treeList = json['GeoInfoOfRoadsideTreeW']['row'];
      final int cnt = treeList.length;

      for (int i = 0; i < cnt; i++) {
        try {
          double lat = double.parse(treeList[i]['LAT']);
          double lng = double.parse(treeList[i]['LNG']);
          //print('lat >> $lat,  lng >> $lng');
          var dist = distance(LatLng(37.561649, 126.993120), LatLng(lat, lng));
          //print(dist);
          if (dist < 300) {
            list.add(RoadTree.fromJson(treeList[i]));
          }
        } on Exception {

        }
      }
      //print('count >> ${list.length}');
    }

    setState(() {
      _treeData = list;
      treeList = list;
    });
  }

  List<Widget> _buildColumn() {
    print('>>> _treeData.length ${_treeData.length}');

    if(_treeData.length == 0){
      return <Widget>[];
    }

    List<Widget> res = [];
    for(RoadTree tree in _treeData) {
      Widget treeColumn = Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('아이디: ${tree.ObjectId}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 50,
                    child: Image.asset('assets/tree.png', fit: BoxFit.cover,)),
                Column(
                  children: <Widget>[
                    Text('수종: ${tree.WDPTName}'),
                    Text('구: ${tree.GUName}'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('lat: ${tree.lat}'),
                    Text('lng: ${tree.lng}'),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
      res.add(treeColumn);
    }
    return res;
  }
}
