import 'package:go_proxy_client/model/subconfigmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'support.dart';

class SubConfigWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleText("订阅配置"),
      SizedBox(height: 16.0),
      Consumer<SubConfigModel>(
        builder: (context, sub, child) => TextField(
          controller: sub.urlController,
          style: TextStyle(color: Colors.black54),
          decoration: textDecoration("代理订阅地址"),
        ),
      ),
      SizedBox(height: 16.0),
      Consumer<SubConfigModel>(
        builder: (context, sub, child) => TextField(
          controller: sub.pathController,
          style: TextStyle(color: Colors.black54),
          decoration: textDecoration("配置保存路径"),
        ),
      ),
      SizedBox(height: 16.0),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FlatButton(
            child: Text("保存配置"),
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              context.read<SubConfigModel>().save(context);
            },
          ),
          SizedBox(width: 16.0),
          FlatButton(
            child: Text("更新订阅"),
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              context.read<SubConfigModel>().update(context);
            },
          ),
        ],
      ),
    ],
  );
}
