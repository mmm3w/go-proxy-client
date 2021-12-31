import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/common.dart';
import '../model/entity.dart';

showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    duration: Duration(milliseconds: 2000),
  ));
}

bool showLoading(BuildContext context) {
  ProgressModel model = Provider.of<ProgressModel>(context, listen: false);
  if (model.isVisible) {
    showSnackBar(context, "请勿频繁操作");
    return false;
  }
  model.setVisible(true);
  return true;
}

hideLoading(BuildContext context) {
  Provider.of<ProgressModel>(context, listen: false).setVisible(false);
}

showServerDialog(
    BuildContext context, List<NiData> data, Function(NiData) onSelect) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Text(data[index].name),
                onTap: () {
                  Navigator.of(context).pop(index);
                  onSelect(data[index]);
                },
              );
            },
          ),
        );
      });
}

onUiAction<T>(Future<T> Function() function, BuildContext context) {
  if (!showLoading(context)) return;
  function().catchError((err) {
    showSnackBar(context, err.toString().trim());
  }).whenComplete(() => hideLoading(context));
}
