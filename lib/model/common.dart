import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_proxy_client/widget/support.dart';
import 'entity.dart';
import 'poster.dart';
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

class SwitchControlModel with ChangeNotifier {
  final String key;
  final SwitchControlPoster poster;
  List<String> source = <String>[];
  String pid = "";

  SwitchControlModel(this.key, this.poster) {
    proxyRunInfo(key).then((value) => setPid(value)).catchError((err) => null);
  }

  void setPid(List<String> data) {
    source.clear();
    source.addAll(data);
    pid = "";
    if (source.length > 0) {
      source.forEach((element) {
        pid += element + ",";
      });
      pid = pid.substring(0, pid.length - 1);
    }
    notifyListeners();
  }

  void refresh() {
    poster.refresh(this);
  }

  bool isEnable() {
    return pid.isNotEmpty;
  }

  void postData(bool enable) {
    poster.postData(this, enable);
  }

  void clear() {
    source.clear();
    pid = "";
    notifyListeners();
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
