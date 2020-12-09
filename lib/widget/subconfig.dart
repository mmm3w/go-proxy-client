import 'package:go_proxy_client/model/subconfigmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../support.dart';
import 'listmanager.dart';

class SubConfigWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            child: titleText("订阅配置"),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: TextField(
              decoration: textDecoration("代理订阅地址"),
              style: TextStyle(color: Colors.black54),
              controller: Provider.of<SubConfigModel>(context, listen: false)
                  .urlController,
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: TextField(
              decoration: textDecoration("配置保存路径"),
              style: TextStyle(color: Colors.black54),
              controller: Provider.of<SubConfigModel>(context, listen: false)
                  .pathController,
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FlatButton(
                  child: Text("保存配置"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () => context.read<SubConfigModel>().save(context),
                ),
                SizedBox(width: 16.0),
                FlatButton(
                  child: Text("更新订阅"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () =>
                      context.read<SubConfigModel>().update(context),
                ),
              ],
            ),
          ),
        ],
      );
}

class SubConfigItem implements ListItem {
  @override
  Widget build(BuildContext context) => SubConfigWidget();
}
