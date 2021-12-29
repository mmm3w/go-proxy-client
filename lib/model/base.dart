import 'package:flutter/cupertino.dart';
import '../widget/support.dart';
import '../request.dart';

class InputModel with ChangeNotifier {
  String cacheData = "";
  final BuildContext context;
  final String key;

  InputModel(this.context, this.key) {
    obtainValue(key).then((value) => setData(value));
  }

  void setData(String data) {
    this.cacheData = data;
    notifyListeners();
  }

  void postData(String data) {
    putValue(key, data).then((value) {
      setData(data);
      showSnackBar(context, "设置成功");
    }).catchError((err) {
      showSnackBar(context, "设置失败：" + err.toString());
    });
  }
}
