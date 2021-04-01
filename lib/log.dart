import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
const minTagLength = 30;
const firstLineSymbol = "-->";
const space = "\u0020";
const hyphen = " - ";
final format = DateFormat("HH:mm:ss");
final formatMillis = DateFormat("HH:mm:ss.SSS");

///
l(
  String text, [
  Object? o,
  Object? o1,
  Object? o2,
  Object? o3,
  Object? o4,
  Object? o5,
]) {
  StringBuffer buffer = StringBuffer();
  buffer.write(_format(text));
  buffer.write(_convertToStringWithHyphenBefore(o));
  buffer.write(_convertToStringWithHyphenBefore(o1));
  buffer.write(_convertToStringWithHyphenBefore(o2));
  buffer.write(_convertToStringWithHyphenBefore(o3));
  buffer.write(_convertToStringWithHyphenBefore(o4));
  buffer.write(_convertToStringWithHyphenBefore(o5));
  debugPrint(buffer.toString());
}

t(String text, [Object? o, Object? o1, Object? o2, Object? o3]) {
  StringBuffer buffer = StringBuffer();
  buffer.write(_format(text, withTime: true));
  buffer.write(_convertToStringWithHyphenBefore(o));
  buffer.write(_convertToStringWithHyphenBefore(o1));
  buffer.write(_convertToStringWithHyphenBefore(o2));
  buffer.write(_convertToStringWithHyphenBefore(o3));
  debugPrint(buffer.toString());
}

ts(String text, [Object? o, Object? o1, Object? o2, Object? o3]) {
  StringBuffer buffer = StringBuffer();
  buffer.write(_format(text, withMilliseconds: true));
  buffer.write(_convertToStringWithHyphenBefore(o));
  buffer.write(_convertToStringWithHyphenBefore(o1));
  buffer.write(_convertToStringWithHyphenBefore(o2));
  buffer.write(_convertToStringWithHyphenBefore(o3));
  debugPrint(buffer.toString());
}

m(String text, [Object? o, Object? o1, Object? o2, Object? o3]) {
  StringBuffer buffer = StringBuffer();
  buffer.write(text);
  buffer.write(_convertToStringWithHyphenBefore(o));
  buffer.write(_convertToStringWithHyphenBefore(o1));
  buffer.write(_convertToStringWithHyphenBefore(o2));
  buffer.write(_convertToStringWithHyphenBefore(o3));
}

req(String message) {}

res(String message) {}

dbReq(String message) {}

dbRes(String message) {}

s(String string) {
  var limit = 500;
  if (string.length > limit) {
    for (int i = 0; i < string.length ~/ limit; i++) {
      print(string.substring(i * limit, (i + 1) * limit));
    }
    print(string.substring(string.length ~/ limit * limit));
  } else {
    print(string);
  }
}

///
_format(
  String text, {
  bool withTime = false,
  bool withMilliseconds = false,
}) {
  StringBuffer buffer = new StringBuffer();
  if (withMilliseconds) {
    buffer.write(formatMillis.format(DateTime.now()) + " " + firstLineSymbol);
  } else if (withTime) {
    buffer.write(format.format(DateTime.now()) + " " + firstLineSymbol);
  } else {
    buffer.write(firstLineSymbol);
  }
  for (int i = 0; i < minTagLength - text.length - (withTime ? 9 : 0); i++) {
    buffer.write(space);
  }
  buffer.write(text);
  return buffer.toString();
}

_convertToStringWithHyphenBefore(Object? obj) {
  return obj != null ? ' - ${obj.toString()}' : '';
}
