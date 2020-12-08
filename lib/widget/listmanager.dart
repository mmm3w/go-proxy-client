
import 'package:flutter/cupertino.dart';

import 'subconfig.dart';

class ListManager{

  int get itemCount => _subConfigManager.count;

  SubConfigManager _subConfigManager = SubConfigManager();

  Widget createWidget(BuildContext context, int index){
    return _subConfigManager.children[index];
  }

}