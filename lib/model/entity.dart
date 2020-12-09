class SubConfig {
  String path;
  String url;

  SubConfig.fromJson(Map<String, dynamic> json)
      : path = json['path'],
        url = json['url'];
}

class STPConfig {
  STPConfig();

  String mode = "";
  bool tcponly = false;
  bool selfonly = false;
  String proxy_svraddr4 = "";
  String proxy_svrport = "";
  String proxy_startcmd = "";
  String proxy_stopcmd = "";
  bool dnsmasq_log_enable = false;
  bool chinadns_verbose = false;
  bool dns2tcp_verbose = false;
  String file_ignlist_ext = "";

  STPConfig.fromJson(Map<String, dynamic> json)
      : mode = json['mode'],
        tcponly = json['tcponly'],
        selfonly = json['selfonly'],
        proxy_svraddr4 = json['proxy_svraddr4'],
        proxy_svrport = json['proxy_svrport'],
        proxy_startcmd = json['proxy_startcmd'],
        proxy_stopcmd = json['proxy_stopcmd'],
        dnsmasq_log_enable = json['dnsmasq_log_enable'],
        chinadns_verbose = json['chinadns_verbose'],
        dns2tcp_verbose = json['dns2tcp_verbose'],
        file_ignlist_ext = json['file_ignlist_ext'];

  Map<String, dynamic> toJson() {
    return {
      'mode': mode,
      'tcponly': tcponly,
      'selfonly': selfonly,
      'proxy_svraddr4': proxy_svraddr4,
      'proxy_svrport': proxy_svrport,
      'proxy_startcmd': proxy_startcmd,
      'proxy_stopcmd': proxy_stopcmd,
      'dnsmasq_log_enable': dnsmasq_log_enable,
      'chinadns_verbose': chinadns_verbose,
      'dns2tcp_verbose': dns2tcp_verbose,
      'file_ignlist_ext': file_ignlist_ext,
    };
  }
}

class V2rayServer {
  String host;
  String path;
  String tls;
  String add;
  int port;
  int aid;
  String net;
  String v;
  String type;
  String ps;
  String id;

  V2rayServer.fromJson(Map<String, dynamic> json)
      : host = json['host'],
        path = json['path'],
        tls = json['tls'],
        add = json['add'],
        port = json['port'],
        aid = json['aid'],
        net = json['net'],
        v = json['v'],
        type = json['type'],
        ps = json['ps'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    return {
      'host': host,
      'path': path,
      'tls': tls,
      'add': add,
      'port': port,
      'aid': aid,
      'net': net,
      'v': v,
      'type': type,
      'ps': ps,
      'id': id,
    };
  }
}
