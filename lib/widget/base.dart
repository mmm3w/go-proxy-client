import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/base.dart';

//标题
class TitleItem extends StatelessWidget {
  final String title;

  TitleItem(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.blue, width: 1),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.blue,
          fontSize: 16,
        ),
      ),
    );
  }
}

//基础子项
class ListItem extends StatelessWidget {
  final String name;
  final Widget widget;

  ListItem(this.name, this.widget);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 8),
              child: Text(this.name),
              alignment: Alignment.centerRight,
            ),
            flex: 7,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8),
              child: widget,
              alignment: Alignment.centerLeft,
            ),
            flex: 18,
          ),
        ],
      ),
    );
  }
}

//开关
class PControlItem extends StatelessWidget {
  final String name;

  PControlItem(this.name);

  @override
  Widget build(BuildContext context) {
    return ListItem(
      this.name,
      Row(
        children: [
          Switch(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: true,
            onChanged: (change) {},
          ),
          Offstage(
            offstage: false,
            child: Text(
              "pid content",
              style: TextStyle(color: Colors.green),
            ), //
          ),
          TextButton(
            child: Text(
              "强制关闭",
              style: TextStyle(fontSize: 12),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

//可编辑项
class EditConfigItem extends StatelessWidget {
  final String name;

  EditConfigItem(this.name);

  @override
  Widget build(BuildContext context) {
    return ListItem(
      name,
      Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Consumer<InputModel>(
            builder: (context, model, child) {
              return TextField(
                style: TextStyle(fontSize: 13),
                controller: TextEditingController()
                  ..text = model.cacheData,
                cursorWidth: 1,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  isDense: true,
                ),
                onSubmitted: (value) {
                  model.postData(value);
                },
              );
            }, // return builder(model);
          )),
    );
  }
}

//弹窗选择项
class SelectConfigItem extends StatelessWidget {
  final String name;
  final String rawData;

  SelectConfigItem(this.name, this.rawData);

  @override
  Widget build(BuildContext context) {
    return ListItem(
      name,
      TextButton(
        onPressed: () {},
        child: Text(this.rawData),
      ),
    );
  }
}

//仅展示项
class ShowConfigItem extends StatelessWidget {
  final String name;
  final String data;

  ShowConfigItem(this.name, this.data);

  @override
  Widget build(BuildContext context) {
    return ListItem(
      name,
      Text(
        this.data,
      ),
    );
  }
}

//定死内容，直接根据内容加载
//upd白名单编辑 开启关闭
//ssr流量白名单编辑
//v2ray 配置定死，留出独立文件

//左侧统一的标题
//右侧会有单行输入框，展示框，多行输入框，
