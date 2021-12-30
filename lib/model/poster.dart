import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'entity.dart';
import 'request.dart';
import '../widget/support.dart';
import 'common.dart';

class InputPoster extends Poster<EditModel, String> {
  final BuildContext context;

  InputPoster(this.context);

  @override
  void post(EditModel model, String data) {
    if (!showLoading(context)) return;
    putValue(model.key, data)
        .then((value) {
          model.setData(data);
          showSnackBar(context, "设置成功");
        })
        .catchError((err) => showSnackBar(context, "设置失败：" + err.toString()))
        .whenComplete(() => hideLoading(context));
  }
}

class ServerSelectPoster extends Poster<ServerSelectModel, NiData> {
  final BuildContext context;

  ServerSelectPoster(this.context);

  @override
  void post(ServerSelectModel model, data) {
    requestList(context, model);
  }

  requestList(BuildContext context, ServerSelectModel model) {
    if (!showLoading(context)) return;
    //加载数据列表并弹窗
    serverConfig(model.key)
        .then((value) => showServerDialog(
            context, value, (data) => postValue(context, model, data)))
        .catchError((err) {
      showSnackBar(context, err.toString().trim());
    }).whenComplete(() => hideLoading(context));
  }

  postValue(BuildContext context, ServerSelectModel model, NiData niData) {
    if (!showLoading(context)) return;
    putValue(model.key, json.encode(niData))
        .then((value) {
          model.setData(niData);
          showSnackBar(context, "设置成功");
        })
        .catchError((err) => showSnackBar(context, "设置失败：" + err.toString()))
        .whenComplete(() => hideLoading(context));
  }
}

obtainSubWithAction(BuildContext context, String type) {
  if (!showLoading(context)) return;
  obtainSub(type)
      .then((value) => showSnackBar(context, value))
      .catchError((err) => showSnackBar(context, err.toString().trim()))
      .whenComplete(() => hideLoading(context));
}
