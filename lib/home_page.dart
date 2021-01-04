import 'package:flutter/material.dart';
import 'package:global_error_handling/report_error.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String textContent = '';

  @override
  Widget build(BuildContext context) {
    EdgeInsets paddingEdges =
        const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0, right: 20.0);

    Future<String> longFunction() async {
      await Future.delayed(Duration(seconds: 10), () {});
      return "Value";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Centralização de erros'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(textContent),
            Container(padding: paddingEdges, child: Text('Forçar erros: ')),
            Container(
              padding: paddingEdges,
              width: double.infinity,
              child: RaisedButton(
                  child: Text('Pure Dart error (sem try catch)'),
                  onPressed: () async {
                    await longFunction().timeout(Duration(seconds: 1));
                  }),
            ),
            Container(
              padding: paddingEdges,
              width: double.infinity,
              child: RaisedButton(
                  child: Text('Pure Dart error (com try catch)'),
                  onPressed: () async {
                    try {
                      await longFunction().timeout(Duration(seconds: 1));
                    } catch(e, stackTrace) {
                      ReportError.report(error: e, stack: stackTrace);
                    }
                  }),
            ),
            Container(
              padding: paddingEdges,
              width: double.infinity,
              child: RaisedButton(
                  child: Text('Ao clicar (sem try catch)'),
                  onPressed: () =>
                      throw Exception('teste de erro (exception)')),
            ),
            Container(
              padding: paddingEdges,
              width: double.infinity,
              child: RaisedButton(
                  child: Text('Ao clicar (com try catch)'),
                  onPressed: () {
                    try {
                      throw ('teste de erro tratado');
                    } catch (e, stackTrace) {
                      ReportError.report(error: e, stack: stackTrace);
                      print('tratamento do erro: $e');
                      // throw e;
                    }
                  }),
            ),
            Container(
              padding: paddingEdges,
              width: double.infinity,
              child: RaisedButton(
                  child: Text('Chamando um método (sem try catch)'),
                  onPressed: () => _metodoComErro()),
            ),
            Container(
              padding: paddingEdges,
              width: double.infinity,
              child: RaisedButton(
                  child: Text('Chamando um método (com try catch)'),
                  onPressed: () {
                    try {
                      _metodoComErro();
                    } catch (e) {
                      ReportError.report(error: e);
                      print('tratamento do erro: $e');
                    }
                  }),
            ),
            Container(
              padding: paddingEdges,
              width: double.infinity,
              child: RaisedButton(
                  child: Text('Aninhado (reporte no nível mais interno)'),
                  onPressed: () {
                    try {
                      _metodoComErro();
                    } catch (e) {
                      try {
                        throw Exception(e.toString());
                      } on Exception catch (e2) {
                        print('tratamento do erro: $e2');
                        ReportError.report(error: e2);
                      }
                    }
                  }),
            ),
            Container(
              padding: paddingEdges,
              width: double.infinity,
              child: RaisedButton(
                  child: Text('Aninhado (reporte em todos os níveis)'),
                  onPressed: () {
                    try {
                      _metodoComErro();
                    } catch (e) {
                      try {
                        ReportError.report(error: e);
                        throw Exception(e.toString());
                      } on Exception catch (e2) {
                        print('tratamento do erro: $e2');
                        ReportError.report(error: e2);
                      }
                    }
                  }),
            ),
            Container(
              padding: paddingEdges,
              width: double.infinity,
              child: RaisedButton(
                  color: Colors.redAccent,
                  child: Text('Fatal Error'),
                  onPressed: () => setState(() => textContent = null)),
            ),
          ],
        ),
      ),
    );
  }

  _metodoComErro() {
    throw ('teste de erro em método');
  }
}
