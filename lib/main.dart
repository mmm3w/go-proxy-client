import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/common.dart';
import 'model/poster.dart';
import 'widget/common.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => ProgressModel(),
          child: MainPage(),
        ),
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
          child: Stack(
            children: [
              ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  TitleItem("通用配置"),
                  PControlItem("脚本状态"),
                  ChangeNotifierProvider(
                    create: (context) =>
                        EditModel("sub_cache_folder", InputPoster(context)),
                    child: EditConfigItem("订阅缓存"),
                  ),
                  TitleItem("V2ray配置"),
                  PControlItem("运行状态"),
                  ChangeNotifierProvider(
                    create: (context) =>
                        ServerSelectModel("v2ray", ServerSelectPoster(context)),
                    child: SelectConfigItem("当前配置"),
                  ),
                  ChangeNotifierProvider(
                    create: (context) =>
                        EditModel("v2ray_config_file", InputPoster(context)),
                    child: EditConfigItem("配置文件"),
                  ),
                  ChangeNotifierProvider(
                    create: (context) =>
                        EditModel("v2ray_sub_url", InputPoster(context)),
                    child: EditConfigItem("订阅地址"),
                  ),
                  SubControlItem("v2ray"),
                  TitleItem("SSR配置"),
                  PControlItem("运行状态"),
                  ChangeNotifierProvider(
                    create: (context) =>
                        ServerSelectModel("ssr", ServerSelectPoster(context)),
                    child: SelectConfigItem("当前配置"),
                  ),
                  ChangeNotifierProvider(
                    create: (context) =>
                        EditModel("ssr_config_file", InputPoster(context)),
                    child: EditConfigItem("配置目录"),
                  ),
                  ChangeNotifierProvider(
                    create: (context) =>
                        EditModel("ssr_sub_url", InputPoster(context)),
                    child: EditConfigItem("订阅地址"),
                  ),
                  SubControlItem("ssr"),
                  TitleItem("其他参数"),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 20,
                  width: 20,
                  margin: EdgeInsets.only(bottom: 16),
                  child: Progress(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
