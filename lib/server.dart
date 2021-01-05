import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Server {

  /*
   * Sending to Graylog
   *
   * GRAYLOG: https://www.graylog.org/products/open-source
   * GELF: https://docs.graylog.org/en/4.0/pages/sending/gelf.html#
   *
   */

  static sendLogger(FlutterErrorDetails errorDetails) async {
    try {
      var logError = {
        "short_message": errorDetails.library,
        "host": "birdId app",
        "description": errorDetails.context?.toDescription() ?? "",
        "error_message": errorDetails.exception.toString(),
        "stack_trace": errorDetails.stack.toString(),
      };

      String bodyEncoded = json.encode(logError);

      var result =
          await http.post('http://192.168.0.174:12201/gelf', body: bodyEncoded);
      print("result: $result");

      return result;
    } catch (e) {
      print("error: $e");
    }
  }
}
