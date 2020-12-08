import 'package:flutter/cupertino.dart';

import '../request.dart';
import '../support.dart';
import 'entity.dart';

class STPConfModel with ChangeNotifier {
  STPConfModel() {
    obtainSTPConfig()
        .then((value) => confPathController.text = value)
        .whenComplete(() => notifyListeners());
  }

  TextEditingController confPathController = TextEditingController(text: "");
}

class STPStateModel with ChangeNotifier {
  STPStateModel() {
    isScriptRunning()
        .then((value) => isRunning = value)
        .catchError((_) => isRunning = false)
        .whenComplete(() => notifyListeners());
  }

  bool isRunning = false;

  control(BuildContext context) {
    showLoading(context);
    controlScript(isRunning).whenComplete(() {
      isScriptRunning().then((value) => isRunning = value).catchError((e) {
        isRunning = false;
        showSnackBar(context, e.toString());
      }).whenComplete(() {
        Navigator.of(context).pop(1);
        notifyListeners();
      });
    });
  }

  status(BuildContext context) {
    showLoading(context);
    scriptStatus().then((value) {
      Navigator.of(context).pop(1);
      showStatusDialog(context, value);
    }).catchError((e) {
      Navigator.of(context).pop(1);
      showSnackBar(context, e.toString());
    }).whenComplete(() => notifyListeners());
  }
}

class STPModel with ChangeNotifier {
  STPModel();

  STPConfig config;
  TextEditingController serverController;
  TextEditingController portController;
  TextEditingController startCmdController;
  TextEditingController stopCmdController;

  TextEditingController ignIpController;
  TextEditingController ignDomainController;

  tcpOnlySwitch(bool value) {
    config.tcponly = value;
    notifyListeners();
  }

  selfOnlySwitch(bool value) {
    config.selfonly = value;
    notifyListeners();
  }

  dnsmasqLogSwitch(bool value) {
    config.dnsmasq_log_enable = value;
    notifyListeners();
  }

  chinadnsLogSwitch(bool value) {
    config.chinadns_verbose = value;
    notifyListeners();
  }

  dns2tcpLogSwitch(bool value) {
    config.dns2tcp_verbose = value;
    notifyListeners();
  }

  load(BuildContext context, String path) {
    showLoading(context);
    loadSTPConfig(path)
        .then((value) {
          config = value;
          serverController = TextEditingController(text: config.proxy_svraddr4);
          portController = TextEditingController(text: config.proxy_svrport);
          startCmdController =
              TextEditingController(text: config.proxy_startcmd);
          stopCmdController = TextEditingController(text: config.proxy_stopcmd);
        })
        .catchError((e) => showSnackBar(context, e.toString()))
        .whenComplete(() {
          Navigator.of(context).pop(1);
          notifyListeners();
        });
  }

  save(BuildContext context) {
    showLoading(context);
    config.proxy_svraddr4 = serverController.text;
    config.proxy_svrport = portController.text;
    config.proxy_startcmd = startCmdController.text;
    config.proxy_stopcmd = stopCmdController.text;

    saveSTPConfig(config)
        .then((value) => showSnackBar(context, "保存成功"))
        .catchError((e) => showSnackBar(context, e.toString()))
        .whenComplete(() {
      Navigator.of(context).pop(1);
    });
  }
}
