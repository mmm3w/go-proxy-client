import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_proxy_client/model/subconfigmodel.dart';
import 'package:provider/provider.dart';

import '../support.dart';

class SubConfigManager {
  int get count => children.length;
  var children = <Widget>[
    titleText("SS-TPROXY配置"),
    Container(
      margin: EdgeInsets.only(top: 16.0),
      child: Consumer<SubConfigModel>(
        builder: (context, model, child) => TextField(
          decoration: textDecoration("代理订阅地址"),
          style: TextStyle(color: Colors.black54),
          controller: model.urlController,
        ),
      ),
    ),
    Container(
      margin: EdgeInsets.only(top: 16.0),
      child: Consumer<SubConfigModel>(
        builder: (context, model, child) => TextField(
          decoration: textDecoration("配置保存路径"),
          style: TextStyle(color: Colors.black54),
          controller: model.pathController,
        ),
      ),
    ),
    Container(
      margin: EdgeInsets.only(top: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FlatButton(
            child: Text("保存配置"),
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
            },
          ),
          SizedBox(width: 16.0),
          FlatButton(
            child: Text("更新订阅"),
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
    ),
  ];
}
