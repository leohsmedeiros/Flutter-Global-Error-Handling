import 'dart:async';

import 'package:flutter/material.dart';
import 'package:global_error_handling/home_page.dart';

void main() async {

  runZonedGuarded<Future>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) {
      //this line prints the default flutter gesture caught exception in console
      // FlutterError.dumpErrorToConsole(details);

      debugPrint("=================== CAUGHT DART ERROR ===================");
      debugPrint("Library :  ${details.library}");
      debugPrint("Description :  ${details.context?.toDescription() ?? ''}");
      debugPrint("Level :  ${details.context?.level?.toString() ?? ''}");
      debugPrint("Error :  ${details.exception}");
      debugPrintStack(stackTrace: details.stack, label: "StackTrace : ");
      debugPrint("=========================================================");
    };

    runApp(MyApp());
  }, (error, stackTrace) {
    debugPrint("=================== CAUGHT runZonedGuarded ERROR ===================");
    FlutterError.reportError(FlutterErrorDetails(exception: error, stack: stackTrace));
    debugPrint("=========================================================");
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
