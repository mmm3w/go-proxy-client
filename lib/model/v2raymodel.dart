import 'package:flutter/cupertino.dart';
import 'package:go_proxy_client/request.dart';
import 'package:go_proxy_client/widget/listmanager.dart';
import 'package:provider/provider.dart';

import '../support.dart';
import 'entity.dart';

class V2rayModel with ChangeNotifier {
  V2rayModel() {
    v2rayStatus()
        .then((value) => pid = value)
        .whenComplete(() => notifyListeners());

    obtainV2rayConfigPath()
        .then((value) => configPathController.text = value)
        .whenComplete(() => notifyListeners());

    obtainV2rayConfigInfo()
        .then((value) => serverInfo = value)
        .whenComplete(() => notifyListeners());
  }

  TextEditingController configPathController = TextEditingController(text: "");

  String pid = "";

  String serverInfo = "";

  bool get isRunning => pid.length > 0;

  String get runningStr => isRunning ? "运行中(pid:" + pid + ")" : "未运行";

  control(BuildContext context) {
    showLoading(context);
    controlV2ray(isRunning).whenComplete(() {
      v2rayStatus().then((value) => pid = value).catchError((e) {
        pid = "";
        showSnackBar(context, e.toString());
      }).whenComplete(() {
        Navigator.of(context).pop(1);
        notifyListeners();
      });
    });
  }

  savePath(BuildContext context) {
    showLoading(context);
    saveV2rayConfigPath(configPathController.text ?? "")
        .then((_) => showSnackBar(context, "保存成功"))
        .catchError((e) => showSnackBar(context, e.toString()))
        .whenComplete(() => Navigator.of(context).pop(1));
  }

  change(BuildContext context) {
    if (Provider.of<ListManager>(context, listen: false).itemCount > 4) {
      Provider.of<ListManager>(context, listen: false).clearServerItem();
    } else {
      showLoading(context);
      obtainConfigSet()
          .then((value) => Provider.of<ListManager>(context, listen: false)
              .showServerItem(value))
          .catchError((e) => showSnackBar(context, e.toString()))
          .whenComplete(() => Navigator.of(context).pop(1));
    }
  }

  post(BuildContext context, V2rayServer data) {
    if (Provider.of<ListManager>(context, listen: false).itemCount <= 4) return;
    showLoading(context);
    postV2rayConfig(data)
        .then((_) {
          showSnackBar(context, "请重启代理进程");
          obtainV2rayConfigInfo()
              .then((value) => serverInfo = value)
              .whenComplete(() => notifyListeners());
        })
        .catchError((e) => showSnackBar(context, e.toString()))
        .whenComplete(() {
          Navigator.of(context).pop(1);
          Provider.of<ListManager>(context, listen: false).clearServerItem();
        });
  }
}
