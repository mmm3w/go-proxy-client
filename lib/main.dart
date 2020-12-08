
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/stpmodel.dart';
import 'model/subconfigmodel.dart';
import 'model/v2raymodel.dart';
import 'stp.dart';
import 'subconfig.dart';
import 'v2ray.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SubConfigModel(context)),
        ChangeNotifierProvider(create: (_) => STPModel()),
        ChangeNotifierProvider(create: (_) => STPConfModel()),
        ChangeNotifierProvider(create: (_) => STPStateModel()),
        ChangeNotifierProvider(create: (_) => V2rayModel()),
      ],
      child: MaterialApp(
        title: 'Proxy Config',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHome(),
      ),
    );
  }
}


class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("代理配置"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SubConfigWidget(),
              SizedBox(height: 16.0),
              V2rayWidget(),
              SizedBox(height: 16.0),
              STPWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
