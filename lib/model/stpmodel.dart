import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

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
  STPStateModel();

  bool isRunning = true;





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
}
