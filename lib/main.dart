import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:treeapi_flutter_app/pages/home_page.dart';
import 'package:http/http.dart';
import 'package:treeapi_flutter_app/services/tree_api.dart' as api;
import 'models/road_tree.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}