import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/base.dart';
import 'widget/base.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 520),
        alignment: Alignment.center,
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              TitleItem("通用配置"),
              PControlItem("脚本状态"),
              ChangeNotifierProvider(
                create: (context) => InputModel(context, "sub_cache_folder"),
                child: EditConfigItem("订阅缓存"),
              ),
              TitleItem("V2ray配置"),
              PControlItem("运行状态"),
              SelectConfigItem("当前配置", "xxxxx"),
              ChangeNotifierProvider(
                create: (context) => InputModel(context, "v2ray_config_file"),
                child: EditConfigItem("配置文件"),
              ),
              ChangeNotifierProvider(
                create: (context) => InputModel(context, "v2ray_sub_url"),
                child: EditConfigItem("订阅地址"),
              ),
              TitleItem("SSR配置"),
              PControlItem("运行状态"),
              SelectConfigItem("当前配置", "xxxxx"),
              ChangeNotifierProvider(
                create: (context) => InputModel(context, "ssr_config_file"),
                child: EditConfigItem("配置目录"),
              ),
              ChangeNotifierProvider(
                create: (context) => InputModel(context,"ssr_sub_url"),
                child: EditConfigItem("订阅地址"),
              ),
              TitleItem("其他参数"),
            ],
          ),
        ),
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'widget/listmanager.dart';
// import 'model/stpmodel.dart';
// import 'model/subconfigmodel.dart';
// import 'model/v2raymodel.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<ListManager>(create: (_) => ListManager()),
//         Provider<SubConfigModel>(create: (_) => SubConfigModel()),
//         ChangeNotifierProvider(create: (_) => V2rayModel()),
//         Provider<STPConfigPathModel>(create: (_) => STPConfigPathModel()),
//         ChangeNotifierProvider(create: (_) => STPStatusModel()),
//         ChangeNotifierProvider(create: (_) => STPModel()),
//       ],
//       child: MaterialApp(
//         title: 'Proxy Config',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: MyHome(),
//       ),
//     );
//   }
// }
//
// class MyHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("代理配置"),
//       ),
//       body: Container(
//         margin: EdgeInsets.all(8.0),
//         child: Consumer<ListManager>(
//           builder: (context, manager, child) => ListView.builder(
//             itemCount: manager.itemCount,
//             itemBuilder: (context, index) {
//               return manager.createWidget(context, index);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
