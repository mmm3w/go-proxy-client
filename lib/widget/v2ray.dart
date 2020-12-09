import 'package:flutter/material.dart';
import 'package:go_proxy_client/model/entity.dart';
import 'package:go_proxy_client/model/v2raymodel.dart';
import 'package:provider/provider.dart';

import '../support.dart';
import 'listmanager.dart';

class V2rayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            child: titleText("V2ray"),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: Provider.of<V2rayModel>(context, listen: false)
                        .configPathController,
                    style: TextStyle(color: Colors.black54),
                    decoration: textDecoration("V2ray配置路径"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16.0),
                  child: FlatButton(
                      child: Text("保存"),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () =>
                          context.read<V2rayModel>().savePath(context)),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Consumer<V2rayModel>(
              builder: (context, model, child) => Row(
                children: [
                  child,
                  Text(
                    model.runningStr,
                    style: TextStyle(
                        color: model.isRunning
                            ? Colors.green[600]
                            : Colors.red[600]),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16.0),
                    child: FlatButton(
                        child: Text(model.isRunning ? "关闭进程" : "启动进程"),
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () => model.control(context)),
                  ),
                ],
              ),
              child: Text("进程状态 : "),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Consumer<V2rayModel>(
              builder: (context, model, child) => FlatButton(
                child: Text("当前代理配置 : " + model.serverInfo),
                onPressed: model.isRunning
                    ? null
                    : () => context.read<V2rayModel>().change(context),
              ),
            ),
          ),
        ],
      );
}

class V2rayItem implements ListItem {
  @override
  Widget build(BuildContext context) => V2rayWidget();
}

class V2rayServerItem extends ListItem {
  final V2rayServer server;

  V2rayServerItem(this.server);

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: MaterialButton(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(server.ps),
                ),
              ],
            ),
          ),
          onPressed: () => context.read<V2rayModel>().post(context, server),
        ),
      );
}
