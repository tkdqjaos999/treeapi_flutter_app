import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:treeapi_flutter_app/models/road_tree.dart';
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
          ..._buildColumn()
        ],
      )
    );
  }

  Future loadData() async {
    var response = await get(api.buildUrl(api.defaultStation));
    String res = response.body;
    print('res >> $res');

    var json = jsonDecode(res);
    List<dynamic> treeList = json['GeoInfoRoadsideTree']['row'];
    final int cnt = treeList.length;

    List<RoadTree> list = List.generate(cnt, (int i){
      Map<String, dynamic> tree = treeList[i];
      print(tree.toString());
      return RoadTree.fromJson(tree);
    });
    setState(() {
      _treeData = list;
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
                    Text('x: ${tree.x}'),
                    Text('y: ${tree.y}'),
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
