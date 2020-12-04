import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:flutter/material.dart';

import 'support.dart';
import 'request.dart';

class SubConfigWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SubConfigWidgetState();
}

class SubConfigWidgetState extends State<SubConfigWidget> {
  var urlEditEnable = false;
  var urlTextController = TextEditingController(text: "");
  var pathEditEnable = false;
  var pathTextController = TextEditingController(text: "");

  var updateSubEnable = false;
  var saveConfigEnable = false;

  // Future obtainSub() async {
  //   String url = "";
  //   String path = "";
  //   try {
  //     var response = await http.get(Uri.parse("http://localhost/subConfig"));
  //     if (response.statusCode == 200) {
  //       var result = json.decode(response.body);
  //       url = result['url'];
  //       path = result['path'];
  //     } else {
  //       snackBar(context, response.body);
  //     }
  //   } catch (exception) {
  //     snackBar(context, exception.toString());
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     urlTextController.text = url;
  //     pathTextController.text = path;
  //     urlEditEnable = true;
  //     pathEditEnable = true;
  //     saveConfigEnable = true;
  //     updateSubEnable = true;
  //   });
  // }

  saveConfig() async {
    enableWidget(false);
    var params = Map<String, String>();
    params["url"] = urlTextController.text;
    params["path"] = pathTextController.text;
    try {
      var response = await http.post(Uri.parse("http://localhost/subConfig"),
          body: params);
      if (response.statusCode == 200) {
        snackBar(context, "保存成功");
      } else {
        snackBar(context, response.body);
      }
    } catch (exception) {
      snackBar(context, exception.toString());
    }
    enableWidget(true);
  }

  updateSub() async {
    enableWidget(false);
    try {
      var response = await http.get(Uri.parse("http://localhost/updateSub"));
      if (response.statusCode == 200) {
        snackBar(context, "更新成功");
      } else {
        snackBar(context, response.body);
      }
    } catch (exception) {
      snackBar(context, exception.toString());
    }
    enableWidget(true);
  }

  enableWidget(bool enable) {
    if (!mounted) return;
    setState(() {
      urlEditEnable = enable;
      pathEditEnable = enable;
      saveConfigEnable = enable;
      updateSubEnable = enable;
    });
  }

  @override
  void initState() {
    obtainSub()
        .then((value) {
          urlTextController.text = value.url;
          pathTextController.text = value.path;
        })
        .catchError((e) => snackBar(context, e.toString()))
        .whenComplete(() {
          // setState(() {});
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.0),
          TextField(
            style: TextStyle(color: Colors.black54),
            controller: urlTextController,
            decoration: textDecoration("代理订阅地址"),
            enabled: urlEditEnable,
          ),
          SizedBox(height: 16.0),
          TextField(
            style: TextStyle(color: Colors.black54),
            controller: pathTextController,
            decoration: textDecoration("配置保存路径"),
            enabled: pathEditEnable,
          ),
          SizedBox(height: 16.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FlatButton(
                child: Text("保存配置"),
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey[200],
                disabledTextColor: Colors.black26,
                onPressed: saveConfigEnable ? saveConfig : null,
              ),
              SizedBox(width: 16.0),
              FlatButton(
                child: Text("更新订阅"),
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey[200],
                disabledTextColor: Colors.black26,
                onPressed: updateSubEnable ? updateSub : null,
              ),
            ],
          ),
        ],
      );
}
