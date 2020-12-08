import 'package:flutter/material.dart';
import 'package:go_proxy_client/model/stpmodel.dart';
import 'package:provider/provider.dart';

import 'support.dart';

class STPWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("SS-TPROXY配置"),
        SizedBox(height: 16.0),
        Consumer<STPConfModel>(
          builder: (context, stp, child) => TextField(
            controller: stp.confPathController,
            style: TextStyle(color: Colors.black54),
            decoration: textDecoration("SS-TPROXY.CONF路径"),
          ),
        ),
        SizedBox(height: 16.0),
        Consumer<STPStateModel>(
          builder: (context, stp, child) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FlatButton(
                  child: Text("加载配置"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    var path =
                        context.read<STPConfModel>().confPathController.text;
                    context.read<STPModel>().load(context, path);
                  }),
              SizedBox(width: 16.0),
              FlatButton(
                  child: Text(stp.isRunning ? "关闭脚本" : "启动脚本"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    stp.control(context);
                  }),
              SizedBox(width: 16.0),
              FlatButton(
                  child: Text("脚本状态"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    stp.status(context);
                  }),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        STPConfWidget()
      ],
    );
  }
}

class STPConfWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<STPModel>(
      builder: (context, stp, child) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: stp.config == null
            ? []
            : [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "模式:" + stp.config.mode,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 16.0),
                    Text("仅TCP:"),
                    Switch(
                      value: stp.config.tcponly,
                      onChanged: Provider.of<STPStateModel>(context).isRunning
                          ? null
                          : (value) {
                              stp.tcpOnlySwitch(value);
                            },
                    ),
                    SizedBox(width: 16.0),
                    Text("仅自机:"),
                    Switch(
                      value: stp.config.selfonly,
                      onChanged: Provider.of<STPStateModel>(context).isRunning
                          ? null
                          : (value) {
                              stp.selfOnlySwitch(value);
                            },
                    )
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.black54),
                        decoration: textDecoration("备选代理服务器"),
                        maxLines: 5,
                        minLines: 1,
                        controller: stp.serverController,
                        enabled: !Provider.of<STPStateModel>(context).isRunning,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    FlatButton(
                        child: Text("Auto"),
                        color: Colors.blue,
                        textColor: Colors.white,
                        disabledColor: Colors.grey[300],
                        disabledTextColor: Colors.grey[450],
                        onPressed: Provider.of<STPStateModel>(context).isRunning
                            ? null
                            : () {}),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.black54),
                        decoration: textDecoration("备选代理服务器端口"),
                        maxLines: 2,
                        minLines: 1,
                        controller: stp.portController,
                        enabled: !Provider.of<STPStateModel>(context).isRunning,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    FlatButton(
                        child: Text("Auto"),
                        color: Colors.blue,
                        textColor: Colors.white,
                        disabledColor: Colors.grey[300],
                        disabledTextColor: Colors.grey[450],
                        onPressed: Provider.of<STPStateModel>(context).isRunning
                            ? null
                            : () {}),
                  ],
                ),
                SizedBox(height: 16.0),
                TextField(
                  style: TextStyle(color: Colors.black54),
                  decoration: textDecoration("代理进程启动命令"),
                  controller: stp.startCmdController,
                  enabled: !Provider.of<STPStateModel>(context).isRunning,
                ),
                SizedBox(height: 16.0),
                TextField(
                  style: TextStyle(color: Colors.black54),
                  decoration: textDecoration("代理进程停止命令"),
                  controller: stp.stopCmdController,
                  enabled: !Provider.of<STPStateModel>(context).isRunning,
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
                    Row(
                      children: [
                        Text("dnsmasq:"),
                        Switch(
                          value: stp.config.dnsmasq_log_enable,
                          onChanged:
                              Provider.of<STPStateModel>(context).isRunning
                                  ? null
                                  : (value) {
                                      stp.dnsmasqLogSwitch(value);
                                    },
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text("china-dns:"),
                        Switch(
                          value: stp.config.chinadns_verbose,
                          onChanged:
                              Provider.of<STPStateModel>(context).isRunning
                                  ? null
                                  : (value) {
                                      stp.chinadnsLogSwitch(value);
                                    },
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text("dns2tcp:"),
                        Switch(
                          value: stp.config.dns2tcp_verbose,
                          onChanged:
                              Provider.of<STPStateModel>(context).isRunning
                                  ? null
                                  : (value) {
                                      stp.dns2tcpLogSwitch(value);
                                    },
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  "ignlist配置路径：" + stp.config.file_ignlist_ext,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 16.0),
                TextField(
                  style: TextStyle(color: Colors.black54),
                  decoration: textDecoration("ignlist ip列表"),
                  maxLines: 5,
                  minLines: 1,
                  controller: stp.ignIpController,
                  enabled: !Provider.of<STPStateModel>(context).isRunning,
                ),
                SizedBox(height: 16.0),
                TextField(
                  style: TextStyle(color: Colors.black54),
                  decoration: textDecoration("ignlist 域名列表"),
                  maxLines: 5,
                  minLines: 1,
                  controller: stp.ignDomainController,
                  enabled: !Provider.of<STPStateModel>(context).isRunning,
                ),
                SizedBox(height: 16.0),
                FlatButton(
                    child: Text("保存配置"),
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey[300],
                    disabledTextColor: Colors.grey[450],
                    onPressed: Provider.of<STPStateModel>(context).isRunning
                        ? null
                        : () {
                            stp.save(context);
                          }),
              ],
      ),
    );
  }
}
