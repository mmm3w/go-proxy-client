import 'dart:convert';

import "package:http/http.dart" as http;

import 'entity.dart';

// import 'model/entity.dart';
//
// // var domain = "http://localhost";
var domain = "http://10.233.1.3:12345";
// // var domain = "http://192.168.0.34";

//
Future<String> obtainValue(String key) async {
  var response = await http.get(Uri.parse(domain + "/config?key=" + key));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw response.body;
  }
}

Future putValue(String key, String value) async {
  var params = Map<String, String>();
  params["key"] = key;
  params["value"] = value;
  var response = await http.post(Uri.parse(domain + "/config"), body: params);
  if (response.statusCode != 200) {
    throw response.body;
  }
}

//当前应用的配置文件
Future<NiData> serverFile(String key) async {
  var response =
      await http.get(Uri.parse(domain + "/currentProxyConfig?key=" + key));
  if (response.statusCode == 200) {
    Utf8Decoder utf8decoder = Utf8Decoder();
    return NiData.fromJson(
        json.decode(utf8decoder.convert(response.bodyBytes)));
  } else {
    throw response.body;
  }
}

//所有配置列表
Future<List<NiData>> serverConfig(String type) async {
  var response =
      await http.get(Uri.parse(domain + "/proxyConfig?type=" + type));
  if (response.statusCode == 200) {
    Utf8Decoder utf8decoder = Utf8Decoder();
    List responseJson = json.decode(utf8decoder.convert(response.bodyBytes));
    return responseJson.map((m) => NiData.fromJson(m)).toList();
  } else {
    throw response.body;
  }
}

Future<String> obtainSub(String type) async {
  var params = Map<String, String>();
  params["type"] = type;
  var response =
      await http.post(Uri.parse(domain + "/updateSub"), body: params);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw response.body;
  }
}

Future<List<String>> proxyRunInfo(String type) async {
  var response =
      await http.get(Uri.parse(domain + "/proxyRunInfo?type=" + type));
  if (response.statusCode == 200) {
    String result = response.body.trim();
    return result.split(" ");
  } else {
    throw response.body;
  }
}

Future stopProxy(String type, String pid) async {
  var params = Map<String, String>();
  params["type"] = type;
  params["pid"] = pid;
  var response =
      await http.post(Uri.parse(domain + "/stopProxy"), body: params);
  if (response.statusCode != 200) {
    throw response.body;
  }
}

Future<List<String>> startProxy(String type) async {
  var params = Map<String, String>();
  params["type"] = type;
  var response =
  await http.post(Uri.parse(domain + "/startProxy"), body: params);
  if (response.statusCode == 200) {
    String result = response.body.trim();
    return result.split(" ");
  } else {
    throw response.body;
  }
}

//
// Future saveConfig(String url, String path) async {
//   var params = Map<String, String>();
//   params["url"] = url;
//   params["path"] = path;
//   var response =
//       await http.post(Uri.parse(domain + "/subConfig"), body: params);
//   if (response.statusCode != 200) {
//     throw response.body;
//   }
// }
//
// Future updateSub() async {
//   var response = await http.get(Uri.parse(domain + "/updateSub"));
//   if (response.statusCode != 200) {
//     throw response.body;
//   }
// }
//
// Future<String> obtainSTPConfig() async {
//   var response = await http.get(Uri.parse(domain + "/tproxyConfigPath"));
//   if (response.statusCode == 200) {
//     return response.body;
//   } else {
//     throw response.body;
//   }
// }
//
// Future<bool> isScriptRunning() async {
//   var response = await http.get(Uri.parse(domain + "/tproxyStatus"));
//   if (response.statusCode == 200) {
//     Map<String, dynamic> status = json.decode(response.body);
//     int count = 0;
//     status.forEach((key, value) {
//       if (!key.contains("pxy") && (value as bool)) {
//         count++;
//       }
//     });
//     return count == 3;
//   } else {
//     throw response.body;
//   }
// }
//
// Future<Map<String, dynamic>> scriptStatus() async {
//   var response = await http.get(Uri.parse(domain + "/tproxyStatus"));
//   if (response.statusCode == 200) {
//     Map<String, dynamic> status = json.decode(response.body);
//     return status;
//   } else {
//     throw response.body;
//   }
// }
//
// Future controlScript(bool isRunning) async {
//   var response;
//   if (isRunning) {
//     response = await http.post(Uri.parse(domain + "/tproxyStop"));
//   } else {
//     response = await http.post(Uri.parse(domain + "/tproxyStart"));
//   }
//   if (response.statusCode != 200) {
//     throw response.body;
//   }
// }
//
// Future<STPConfig> loadSTPConfig(String path) async {
//   Map<String, dynamic> result;
//   var response =
//       await http.get(Uri.parse(domain + "/tproxyConfig?path=" + path));
//   if (response.statusCode == 200) {
//     result = json.decode(response.body);
//   } else {
//     throw response.body;
//   }
//   return STPConfig.fromJson(result);
// }
//
// Future<String> obtainServerSet() async {
//   var response = await http.get(Uri.parse(domain + "/serverSet"));
//   if (response.statusCode == 200) {
//     return response.body;
//   } else {
//     throw response.body;
//   }
// }
//
// Future<String> obtainPortSet() async {
//   var response = await http.get(Uri.parse(domain + "/portSet"));
//   if (response.statusCode == 200) {
//     return response.body;
//   } else {
//     throw response.body;
//   }
// }
//
// Future saveSTPConfig(STPConfig config) async {
//   var params = Map<String, String>();
//   params["data"] = json.encode(config);
//   var response =
//       await http.post(Uri.parse(domain + "/tproxyConfig"), body: params);
//   if (response.statusCode != 200) {
//     throw response.body;
//   }
// }
//
// Future<String> obtainV2rayConfigPath() async {
//   var response = await http.get(Uri.parse(domain + "/v2rayConfigPath"));
//   if (response.statusCode == 200) {
//     return response.body;
//   } else {
//     throw response.body;
//   }
// }
//
// Future<String> obtainV2rayConfigInfo() async {
//   var response = await http.get(Uri.parse(domain + "/v2rayConfigInfo"));
//   if (response.statusCode == 200) {
//     return response.body;
//   } else {
//     throw response.body;
//   }
// }
//
// Future saveV2rayConfigPath(String path) async {
//   var params = Map<String, String>();
//   params["path"] = path;
//   var response =
//       await http.post(Uri.parse(domain + "/v2rayConfigPath"), body: params);
//   if (response.statusCode != 200) {
//     throw response.body;
//   }
// }
//
// Future<String> v2rayStatus() async {
//   var response = await http.get(Uri.parse(domain + "/v2rayStatus"));
//   if (response.statusCode == 200) {
//     return response.body;
//   } else {
//     throw response.body;
//   }
// }
//
// Future controlV2ray(bool isRunning) async {
//   var response;
//   if (isRunning) {
//     response = await http.post(Uri.parse(domain + "/v2rayStop"));
//   } else {
//     response = await http.post(Uri.parse(domain + "/v2rayStart"));
//   }
//   if (response.statusCode != 200) {
//     throw response.body;
//   }
// }
//
// Future postV2rayConfig(V2rayServer data) async {
//   var params = Map<String, String>();
//   params["data"] = json.encode(data);
//   var response =
//       await http.post(Uri.parse(domain + "/v2rayConfig"), body: params);
//   if (response.statusCode != 200) {
//     throw response.body;
//   }
// }
//
// Future<List<V2rayServer>> obtainConfigSet() async {
//   var response = await http.get(Uri.parse(domain + "/configSet"));
//   if (response.statusCode == 200) {
//     List responseJson = json.decode(response.body);
//     return responseJson.map((m) => V2rayServer.fromJson(m)).toList();
//   } else {
//     throw response.body;
//   }
// }
