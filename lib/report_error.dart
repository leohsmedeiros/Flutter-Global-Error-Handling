import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';

class ReportError {
  static report({error, String description = '', String library = ''}) {
    var context = CustomDiagnosticNode(name: description);
    FlutterError.reportError(
        FlutterErrorDetails(exception: error, library: library, context: context));
  }
}

class CustomDiagnosticNode extends DiagnosticsNode {
  CustomDiagnosticNode({String name}) : super(name: name);

  @override
  List<DiagnosticsNode> getChildren() {
    // TODO: implement getChildren
    throw UnimplementedError();
  }

  @override
  List<DiagnosticsNode> getProperties() {
    // TODO: implement getProperties
    throw UnimplementedError();
  }

  @override
  String toDescription({TextTreeConfiguration parentConfiguration}) =>
      this.name ?? '';

  @override
  // TODO: implement value
  Object get value => throw UnimplementedError();
}
