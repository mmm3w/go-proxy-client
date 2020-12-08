import 'package:flutter/material.dart';
import 'package:go_proxy_client/model/v2raymodel.dart';
import 'package:provider/provider.dart';

import 'support.dart';

class V2rayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("V2ray"),
        SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: Provider.of<V2rayModel>(context,listen: false)
                    .configPathController,
                style: TextStyle(color: Colors.black54),
                decoration: textDecoration("V2ray配置路径"),
              ),
            ),
            SizedBox(width: 16.0),
            FlatButton(
                child: Text("保存"),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  context.read<V2rayModel>().savePath(context);
                }),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Row(
              children: [
                Text("进程状态 : "),
                Text(
                  Provider.of<V2rayModel>(context, listen: false).runningStr,
                  style: TextStyle(
                      color: Provider.of<V2rayModel>(context, listen: false)
                              .isRunning
                          ? Colors.green[600]
                          : Colors.red[600]),
                ),
              ],
            ),
            SizedBox(width: 16.0),
            FlatButton(
                child: Text(Provider.of<V2rayModel>(context, listen: false).isRunning
                    ? "关闭进程"
                    : "启动进程"),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  context.read<V2rayModel>().control(context);
                }),
          ],
        ),
        SizedBox(height: 16.0),
        FlatButton(child: Text("当前代理配置：(点击进行切换)"), onPressed: () {}),
      ],
    );
  }
}
