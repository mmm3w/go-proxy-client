import 'package:flutter/material.dart';
import 'package:go_proxy_client/model/stpmodel.dart';
import 'package:go_proxy_client/widget/listmanager.dart';
import 'package:provider/provider.dart';

import '../support.dart';

class STPWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            child: titleText("SS-TPROXY配置"),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: TextField(
              controller:
                  Provider.of<STPConfigPathModel>(context, listen: false)
                      .confPathController,
              style: TextStyle(color: Colors.black54),
              decoration: textDecoration("SS-TPROXY.CONF路径"),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Row(
              children: [
                FlatButton(
                    child: Text("加载配置"),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      var path = context.read<STPConfigPathModel>().configPath;
                      context.read<STPModel>().load(context, path);
                    }),
                Container(
                  margin: EdgeInsets.only(left: 16.0),
                  child: Consumer<STPStatusModel>(
                    builder: (context, model, child) => FlatButton(
                        child: Text(model.isRunning ? "关闭脚本" : "启动脚本"),
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () => model.control(context)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16.0),
                  child: FlatButton(
                      child: Text("脚本状态"),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () =>
                          context.read<STPStatusModel>().status(context)),
                ),
              ],
            ),
          ),
        ],
      );
}

class STPConfigWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<STPModel>(
      builder: (context, model, child) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: model.config == null
            ? []
            : [
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "模式:" + model.config.mode,
                        style: TextStyle(color: Colors.grey),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16.0),
                        child: Text("仅TCP:"),
                      ),
                      Switch(
                        value: model.config.tcponly,
                        onChanged:
                            Provider.of<STPStatusModel>(context).isRunning
                                ? null
                                : (value) => model.tcpOnlySwitch(value),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16.0),
                        child: Text("仅自机:"),
                      ),
                      Switch(
                        value: model.config.selfonly,
                        onChanged:
                            Provider.of<STPStatusModel>(context, listen: false)
                                    .isRunning
                                ? null
                                : (value) => model.selfOnlySwitch(value),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.black54),
                          decoration: textDecoration("备选代理服务器"),
                          maxLines: 5,
                          minLines: 1,
                          controller: model.serverController,
                          enabled: !Provider.of<STPStatusModel>(context,
                                  listen: false)
                              .isRunning,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16.0),
                        child: FlatButton(
                            child: Text("Auto"),
                            color: Colors.blue,
                            textColor: Colors.white,
                            disabledColor: Colors.grey[300],
                            disabledTextColor: Colors.grey[450],
                            onPressed: Provider.of<STPStatusModel>(context,
                                        listen: false)
                                    .isRunning
                                ? null
                                : () => model.autoServerSet(context)),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.black54),
                          decoration: textDecoration("备选代理服务器端口"),
                          maxLines: 5,
                          minLines: 1,
                          controller: model.portController,
                          enabled: !Provider.of<STPStatusModel>(context,
                                  listen: false)
                              .isRunning,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16.0),
                        child: FlatButton(
                            child: Text("Auto"),
                            color: Colors.blue,
                            textColor: Colors.white,
                            disabledColor: Colors.grey[300],
                            disabledTextColor: Colors.grey[450],
                            onPressed: Provider.of<STPStatusModel>(context,
                                        listen: false)
                                    .isRunning
                                ? null
                                : () => model.autoPortSet(context)),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(color: Colors.black54),
                    decoration: textDecoration("代理进程启动命令"),
                    controller: model.startCmdController,
                    enabled:
                        !Provider.of<STPStatusModel>(context, listen: false)
                            .isRunning,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(color: Colors.black54),
                    decoration: textDecoration("代理进程停止命令"),
                    controller: model.stopCmdController,
                    enabled:
                        !Provider.of<STPStatusModel>(context, listen: false)
                            .isRunning,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "日志开关",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("dnsmasq:"),
                      Switch(
                        value: model.config.dnsmasq_log_enable,
                        onChanged:
                            Provider.of<STPStatusModel>(context, listen: false)
                                    .isRunning
                                ? null
                                : (value) => model.dnsmasqLogSwitch(value),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16.0),
                        child: Text("china-dns:"),
                      ),
                      Switch(
                        value: model.config.chinadns_verbose,
                        onChanged:
                            Provider.of<STPStatusModel>(context, listen: false)
                                    .isRunning
                                ? null
                                : (value) => model.chinadnsLogSwitch(value),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16.0),
                        child: Text("dns2tcp:"),
                      ),
                      Switch(
                        value: model.config.dns2tcp_verbose,
                        onChanged:
                            Provider.of<STPStatusModel>(context, listen: false)
                                    .isRunning
                                ? null
                                : (value) => model.dns2tcpLogSwitch(value),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "ignlist配置路径：" + model.config.file_ignlist_ext,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(color: Colors.black54),
                    decoration: textDecoration("ignlist ip列表(未完成功能)"),
                    maxLines: 5,
                    minLines: 1,
                    controller: model.ignIpController,
                    enabled:false,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(color: Colors.black54),
                    decoration: textDecoration("ignlist 域名列表(未完成功能)"),
                    maxLines: 5,
                    minLines: 1,
                    controller: model.ignDomainController,
                    enabled: false,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: FlatButton(
                      child: Text("保存配置"),
                      color: Colors.blue,
                      textColor: Colors.white,
                      disabledColor: Colors.grey[300],
                      disabledTextColor: Colors.grey[450],
                      onPressed:
                          Provider.of<STPStatusModel>(context, listen: false)
                                  .isRunning
                              ? null
                              : () => model.save(context)),
                ),
              ],
      ),
    );
  }
}

class STPItem implements ListItem {
  @override
  Widget build(BuildContext context) => STPWidget();
}

class STPConfigItem implements ListItem {
  Widget build(BuildContext context) => STPConfigWidget();
}
