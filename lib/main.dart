import 'dart:async';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    //this line prints the default flutter gesture caught exception in console
    // FlutterError.dumpErrorToConsole(details);


    debugPrint("=================== CAUGHT DART ERROR ===================");
    debugPrint("Context description :  ${details.context.toDescription()}");
    debugPrint("Error :  ${details.exception}");
    // debugPrint("StackTrace: ${details.stack}");
    debugPrintStack(stackTrace: details.stack, label: "StackTrace");
    debugPrint("=========================================================");
  };
  // runApp(MyApp());

  runZoned<Future<void>>(() async {
    runApp(MyApp());
  }, onError: (error, stackTrace) {
    // Whenever an error occurs, call the `_reportError` function. This sends
    // Dart errors to the dev console or Sentry depending on the environment.
    // _reportError(error, stackTrace);
    print('on error runZoned');
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    EdgeInsets paddingEdges =
        const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0, right: 20.0);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Centralização de erros'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: paddingEdges,
                width: double.infinity,
                child: RaisedButton(
                    child: Text('Forçar erro ao clicar'),
                    onPressed: () => throw Exception('teste de erro (exception)')),
              ),
              Container(
                padding: paddingEdges,
                width: double.infinity,
                child: RaisedButton(
                    child: Text('Forçar erro ao clicar (com try catch)'),
                    onPressed: () {
                      try {
                        throw ('teste de erro tratado');
                      } catch (e) {
                        print('tratamento do erro: $e');
                        throw e;
                      }
                    }),
              ),
              Container(
                padding: paddingEdges,
                width: double.infinity,
                child: RaisedButton(
                    child: Text('Forçar erro ao chamar um método'),
                    onPressed: () => _metodoComErro()),
              ),
              Container(
                padding: paddingEdges,
                width: double.infinity,
                child: RaisedButton(
                    child:
                        Text('Forçar erro ao chamar um método (com try catch)'),
                    onPressed: () {
                      try {
                        _metodoComErro();
                      } catch (e) {
                        print('tratamento do erro: $e');
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _metodoComErro() {
    throw ('teste de erro em método');
  }
}
