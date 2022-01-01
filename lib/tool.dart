import 'dart:convert';

import 'dart:typed_data';

Utf8Decoder utf8decoder = Utf8Decoder();

String utf8D(List<int> data) {
  return utf8decoder.convert(data);
}
