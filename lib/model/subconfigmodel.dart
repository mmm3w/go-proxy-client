import 'package:flutter/cupertino.dart';

import '../request.dart';
import '../support.dart';

class SubConfigModel {
  SubConfigModel() {
    obtainSub().then((value) {
      urlController.text = value.url;
      pathController.text = value.path;
    }).catchError((_) {});
  }

  TextEditingController urlController = TextEditingController(text: "");
  TextEditingController pathController = TextEditingController(text: "");

  save(BuildContext context) {
    showLoading(context);
    saveConfig(urlController.text, pathController.text)
        .then((_) => showSnackBar(context, "保存成功"))
        .catchError((e) => showSnackBar(context, e.toString()))
        .whenComplete(() => Navigator.of(context).pop(1));
  }

  update(BuildContext context) {
    showLoading(context);
    updateSub()
        .then((_) => showSnackBar(context, "更新成功"))
        .catchError((e) => showSnackBar(context, e.toString()))
        .whenComplete(() => Navigator.of(context).pop(1));
  }
}
