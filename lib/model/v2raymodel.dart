import 'package:flutter/cupertino.dart';
import 'package:go_proxy_client/request.dart';

import '../support.dart';

class V2rayModel with ChangeNotifier {
  V2rayModel() {
    v2rayStatus().then((value) => pid = value).whenComplete(() {
      notifyListeners();
    });

    obtainV2rayConfigPath().then((value) {
      configPathController.text = value;
    }).whenComplete(() {
      notifyListeners();
    });
  }

  TextEditingController configPathController = TextEditingController(text: "");

  String pid = "";

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
}
