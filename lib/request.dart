import 'dart:convert';
import "package:http/http.dart" as http;
import 'entity.dart';

Future<SubConfig> obtainSub() async {
  String url = "";
  String path = "";
  var response = await http.get(Uri.parse("http://localhost/subConfig"));
  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    url = result['url'];
    path = result['path'];
  } else {
    throw response.body;
  }
  return SubConfig(path, url);
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
