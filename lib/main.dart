import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widget/listmanager.dart';
import 'model/stpmodel.dart';
import 'model/subconfigmodel.dart';
import 'model/v2raymodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListManager>(create: (_) => ListManager()),
        Provider<SubConfigModel>(create: (_) => SubConfigModel()),
        ChangeNotifierProvider(create: (_) => V2rayModel()),
        Provider<STPConfigPathModel>(create: (_) => STPConfigPathModel()),
        ChangeNotifierProvider(create: (_) => STPStatusModel()),
        ChangeNotifierProvider(create: (_) => STPModel()),
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
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: Consumer<ListManager>(
          builder: (context, manager, child) => ListView.builder(
            itemCount: manager.itemCount,
            itemBuilder: (context, index) {
              return manager.createWidget(context, index);
            },
          ),
        ),
      ),
    );
  }
}
