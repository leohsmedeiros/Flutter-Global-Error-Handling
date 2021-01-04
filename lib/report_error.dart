import 'package:flutter/material.dart';

class ReportError {
  static report({error, StackTrace stack}) {
    if (stack != null) {
      FlutterError.reportError(FlutterErrorDetails(exception: error, stack: stack));
    } else {
      FlutterError.reportError(FlutterErrorDetails(exception: error));
    }
  }
}
