import 'dart:convert';
import 'dart:developer';

enum LogLevel {
  debug('DEBUG'),
  info('INFO'),
  warning('WARNING'),
  error('ERROR');

  final String value;

  const LogLevel(this.value);
}

class Log {
  static void console(dynamic logObject, {LogLevel level = LogLevel.debug, String? where}) {
    log(_toJson(logObject), name: '${level.value}: ${where ?? ''}', level: level.index);
  }

  static _toJson(dynamic object) {
    if (object is String || object is num || object is bool) {
      return object;
    } else if (object is Map || object is List) {
      return const JsonEncoder.withIndent('  ').convert(object);
    } else {
      try {
        return object.toJson();
      } catch (e) {
        return object.toString();
      }
    }
  }
}
