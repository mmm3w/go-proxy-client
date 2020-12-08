import 'package:flutter/material.dart';
import 'package:go_proxy_client/model/v2raymodel.dart';
import 'package:provider/provider.dart';

import 'support.dart';

class V2rayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<V2rayModel>(
      builder: (context, v2ray, child) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleText("V2ray"),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: v2ray.configPathController,
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
                    v2ray.savePath(context);
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
                    v2ray.runningStr,
                    style: TextStyle(
                        color: v2ray.isRunning
                            ? Colors.green[600]
                            : Colors.red[600]),
                  ),
                ],
              ),
              SizedBox(width: 16.0),
              FlatButton(
                  child: Text(v2ray.isRunning ? "关闭进程" : "启动进程"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    v2ray.control(context);
                  }),
            ],
          ),
          SizedBox(height: 16.0),
          FlatButton(child: Text("当前代理配置：(点击进行切换)"), onPressed: () {}),
        ],
      ),
    );
  }
}
