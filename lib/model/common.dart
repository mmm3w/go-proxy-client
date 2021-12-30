import 'package:flutter/cupertino.dart';
import 'entity.dart';
import 'request.dart';

abstract class Poster<M, D> {
  void post(M model, D data);
}

//全局loading
class ProgressModel with ChangeNotifier {
  bool isVisible = false;

  void setVisible(bool visible) {
    isVisible = visible;
    notifyListeners();
  }
}

class EditModel with ChangeNotifier {
  String cacheData = "";
  final String key;
  final Poster<EditModel, String> poster;

  EditModel(this.key, this.poster) {
    obtainValue(key).then((value) => setData(value)).catchError((err) => null);
  }

  void setData(String data) {
    this.cacheData = data;
    notifyListeners();
  }

  void postData(String data) {
    poster.post(this, data);
  }
}

class ServerSelectModel with ChangeNotifier {
  final String key;
  final Poster<ServerSelectModel, NiData> poster;
  String name = "";
  String id = "";

  ServerSelectModel(this.key, this.poster) {
    serverFile(key).then((value) => setData(value)).catchError((err) => null);
  }

  void setData(NiData data) {
    if (data == null) return;
    this.name = data.name;
    this.id = data.id;
    notifyListeners();
  }

  void postData() {
    poster.post(this, null);
  }
}

