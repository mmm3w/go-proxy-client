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
    onUiAction(() {
      return putValue(model.key, data).then((value) {
        model.setData(data);
        showSnackBar(context, "设置成功");
      });
    }, context);
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
    onUiAction(() {
      return serverConfig(model.key).then((value) => showServerDialog(
          context, value, (data) => postValue(context, model, data)));
    }, context);
  }

  postValue(BuildContext context, ServerSelectModel model, NiData niData) {
    onUiAction(() {
      return putValue(model.key, json.encode(niData)).then((value) {
        model.setData(niData);
        showSnackBar(context, "设置成功");
      });
    }, context);
  }
}

class SwitchControlPoster {
  final BuildContext context;

  SwitchControlPoster(this.context);

  void refresh(SwitchControlModel model) {
    onUiAction(
        () => proxyRunInfo(model.key).then((value) => model.setPid(value)),
        context);
  }

  void postData(SwitchControlModel model, bool enable) {
    if (enable) {
      //打开
      onUiAction(
          () => startProxy(model.key).then((value) => model.setPid(value)),
          context);
    } else {
      //关闭
      onUiAction(
          () => stopProxy(model.key, model.pid).then((value) => model.clear()),
          context);
    }
  }
}

obtainSubWithAction(BuildContext context, String type) {
  onUiAction(() {
    return obtainSub(type).then((value) => showSnackBar(context, value));
  }, context);
}
