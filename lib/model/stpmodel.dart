import 'package:flutter/cupertino.dart';

import '../request.dart';
import '../support.dart';
import 'entity.dart';

class STPModel with ChangeNotifier {
  STPModel(BuildContext context) {
    obtainSTPConfig()
        .then((value) {
          confPathController.text = value;
        })
        .whenComplete(() => notifyListeners());
  }

  String confPath = "";

  STPConfig config;

  TextEditingController confPathController = TextEditingController(text: "");

  load(BuildContext context) {
    showLoading(context);
    loadSTPConfig(confPathController.text)
        .then((value) => config = value)
        .catchError((e) => showSnackBar(context, e.toString()))
        .whenComplete(() {
      Navigator.of(context).pop(1);
      notifyListeners();
    });
  }
}
