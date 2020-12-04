import 'package:flutter/material.dart';

import 'support.dart';

class STPWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => STPWidgetState();
}

class STPWidgetState extends State<STPWidget> {


  var stpConfigController = TextEditingController(text: "");




  obtainConfPath() async{

  }





  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.0),
        TextField(
          controller: stpConfigController,

          style: TextStyle(color: Colors.black54),
          decoration: textDecoration("SS-TPROXY.CONF路径"),
        ),
        SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FlatButton(
                child: Text("加载配置"), color: Colors.black12, onPressed: () {}),
            SizedBox(width: 16.0),
            FlatButton(
                child: Text("启动/关闭脚本"),
                color: Colors.black12,
                onPressed: () {}),
            SizedBox(width: 16.0),
            FlatButton(
                child: Text("脚本状态"), color: Colors.black12, onPressed: () {}),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "模式：chnroute",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(width: 16.0),
            Text("仅TCP:"),
            Switch(
              value: false,
              onChanged: (value) {},
            ),
            SizedBox(width: 16.0),
            Text("仅自机:"),
            Switch(
              value: false,
              onChanged: (value) {},
            )
          ],
        ),
        SizedBox(height: 16.0),
        TextField(
          style: TextStyle(color: Colors.black54),
          decoration: textDecoration("备选代理服务器"),
          maxLines: 5,
          minLines: 1,
        ),
        SizedBox(height: 16.0),
        TextField(
          style: TextStyle(color: Colors.black54),
          decoration: textDecoration("备选代理服务器端口"),
          maxLines: 2,
          minLines: 1,
        ),
        SizedBox(height: 16.0),
        TextField(
          style: TextStyle(color: Colors.black54),
          decoration: textDecoration("代理进程启动命令"),
        ),
        SizedBox(height: 16.0),
        TextField(
          style: TextStyle(color: Colors.black54),
          decoration: textDecoration("代理进程停止命令"),
        ),
        SizedBox(height: 16.0),
        Text(
          "日志开关",
          style: TextStyle(fontSize: 16),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Text("dnsmasq:"),
                  Switch(
                    value: false,
                    onChanged: (value) {},
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Text("china-dns:"),
                  Switch(
                    value: false,
                    onChanged: (value) {},
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Text("dns2tcp:"),
                  Switch(
                    value: false,
                    onChanged: (value) {},
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          "ignlist配置路径：",
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 16.0),
        TextField(
          style: TextStyle(color: Colors.black54),
          decoration: textDecoration("ignlist ip列表"),
          maxLines: 5,
          minLines: 1,
        ),
        SizedBox(height: 16.0),
        TextField(
          style: TextStyle(color: Colors.black54),
          decoration: textDecoration("ignlist 域名列表"),
          maxLines: 5,
          minLines: 1,
        ),
        SizedBox(height: 16.0),
        FlatButton(
            child: Text("保存配置"), color: Colors.black12, onPressed: () {}),
      ],
    );
  }
}