import 'package:flutter/cupertino.dart';

import '../request.dart';
import '../support.dart';
import 'entity.dart';

class STPConfigPathModel {
  STPConfigPathModel() {
    obtainSTPConfig()
        .then((value) => confPathController.text = value)
        .catchError((_) {});
  }

  TextEditingController confPathController = TextEditingController(text: "");

  String get configPath => confPathController.text;
}

class STPStatusModel with ChangeNotifier {
  STPStatusModel() {
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
    });
  }
}

class STPModel with ChangeNotifier {
  STPModel();

  STPConfig config;
  TextEditingController serverController = TextEditingController(text: "");
  TextEditingController portController = TextEditingController(text: "");
  TextEditingController startCmdController = TextEditingController(text: "");
  TextEditingController stopCmdController = TextEditingController(text: "");

  TextEditingController ignIpController = TextEditingController(text: "");
  TextEditingController ignDomainController = TextEditingController(text: "");

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

  autoServerSet(BuildContext context) {
    showLoading(context);
    obtainServerSet()
        .then((value) => serverController.text = value)
        .catchError((e) => showSnackBar(context, e.toString()))
        .whenComplete(() {
      Navigator.of(context).pop(1);
      notifyListeners();
    });
  }

  autoPortSet(BuildContext context) {
    showLoading(context);
    obtainPortSet()
        .then((value) => portController.text = value)
        .catchError((e) => showSnackBar(context, e.toString()))
        .whenComplete(() {
      Navigator.of(context).pop(1);
      notifyListeners();
    });
  }

  load(BuildContext context, String path) {
    showLoading(context);
    loadSTPConfig(path)
        .then((value) {
          config = value;
          serverController.text = config.proxy_svraddr4;
          portController.text = config.proxy_svrport;
          startCmdController.text = config.proxy_startcmd;
          stopCmdController.text = config.proxy_stopcmd;
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
        .whenComplete(() => Navigator.of(context).pop(1));
  }
}
