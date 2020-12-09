import 'package:flutter/cupertino.dart';
import 'package:go_proxy_client/model/entity.dart';
import 'package:go_proxy_client/widget/stp.dart';
import 'package:go_proxy_client/widget/v2ray.dart';

import 'subconfig.dart';

abstract class ListItem {
  Widget build(BuildContext context);
}

class ListManager with ChangeNotifier {
  int get itemCount => items.length;

  final items = <ListItem>[
    SubConfigItem(),
    V2rayItem(),
    STPItem(),
    STPConfigItem()
  ];

  Widget createWidget(BuildContext context, int index) =>
      items[index].build(context);

  showServerItem(List<V2rayServer> data) {
    List<ListItem> newItem = data.map((m) => V2rayServerItem(m)).toList();
    items.insertAll(2, newItem);
    notifyListeners();
  }

  clearServerItem() {
    items.removeRange(2, itemCount - 2);
    notifyListeners();
  }
}
