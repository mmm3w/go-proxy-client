import 'dart:convert';
import "package:http/http.dart" as http;
import 'model/entity.dart';

Future<SubConfig> obtainSub() async {
  Map<String, dynamic> result;
  var response = await http.get(Uri.parse("http://localhost/subConfig"));
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
      await http.post(Uri.parse("http://localhost/subConfig"), body: params);
  if (response.statusCode != 200) {
    throw response.body;
  }
}

Future updateSub() async {
  var response = await http.get(Uri.parse("http://localhost/updateSub"));
  if (response.statusCode != 200) {
    throw response.body;
  }
}

Future<String> obtainSTPConfig() async {
  var response = await http.get(Uri.parse("http://localhost/tproxyConfigPath"));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw response.body;
  }
}

Future<STPConfig> loadSTPConfig(String path) async {
  var params = Map<String, String>();
  params["path"] = path;
  Map<String, dynamic> result;
  var response = await http
      .post(Uri.parse("http://localhost/tproxyConfig"),body: params);
  if (response.statusCode == 200) {
    result = json.decode(response.body);
  } else {
    throw response.body;
  }
  return STPConfig.fromJson(result);
}
