import 'dart:convert';
import "package:http/http.dart" as http;
import 'model/entity.dart';


var domain = "http://localhost";

Future<SubConfig> obtainSub() async {
  Map<String, dynamic> result;
  var response = await http.get(Uri.parse(domain + "/subConfig"));
  if (response.statusCode == 200) {
    result = json.decode(response.body);
  } else {
    throw response.body;
  }
  return SubConfig.fromJson(result);
}

Future saveConfig(String url, String path) async {
  var params = Map<String, String>();
  params["url"] = url;
  params["path"] = path;
  var response =
  await http.post(Uri.parse(domain + "/subConfig"), body: params);
  if (response.statusCode != 200) {
    throw response.body;
  }
}

Future updateSub() async {
  var response = await http.get(Uri.parse(domain + "/updateSub"));
  if (response.statusCode != 200) {
    throw response.body;
  }
}

Future<String> obtainSTPConfig() async {
  var response = await http.get(Uri.parse(domain + "/tproxyConfigPath"));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw response.body;
  }
}

Future<bool> isScriptRunning() async {
  return false;
}

Future<STPConfig> loadSTPConfig(String path) async {
  var params = Map<String, String>();
  params["path"] = path;
  Map<String, dynamic> result;
  var response = await http
      .get(Uri.parse(domain + "/tproxyConfig?path="+path));
  if (response.statusCode == 200) {
    result = json.decode(response.body);
  } else {
    throw response.body;
  }
  return STPConfig.fromJson(result);
}
