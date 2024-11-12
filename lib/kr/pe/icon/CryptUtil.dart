import 'dart:convert';
import 'package:flutter/material.dart';

import 'base64Util.dart';

class CryptUtil {
  static String toBase64(String value) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.encode(value);
  }

  static List<int> toUTF8Bytes(String value) {
    return utf8.encode(value);
  }

  static String fromBase64(String value, {bool bUTF8 = true}) {
    return Base64Util.decode(value, UTF8Encode: bUTF8); //String.fromCharCodes(base64.decode(value));
  }

  static List<int> fromBase64Bytes(String value) {
    List<int> src = Base64Util.decode(value).codeUnits;
    List<int> des = List.filled(src.length, 0);
    try {
      covertArraySignByteToInt(src, des);
    } catch (e) {
      debugPrint('fromBase64Bytes error ${e.toString()}');
    }
    return des;
  }

  static void covertArrayByteToInt(List<int> src, List<int> des) {
    for (int i = 0; i < src.length; i++) {
      des[i] = (src[i]).toUnsigned(8);
    }
  }

  static void covertArraySignByteToInt(List<int> src, List<int> des) {
    for (int i = 0; i < src.length; i++) {
      des[i] = (src[i]).toSigned(8);
    }
  }

  static String fromBase64List(List<int> value) {
    return Base64Encoder().convert(value);
  }

  static String toBase64URL(String value) {
    return base64Url.encode(utf8.encode(value));
  }

  static String fromBase64URL(String value) {
    return utf8.decode(base64Url.decode(value));
  }
}
