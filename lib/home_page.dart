import 'package:flutter/material.dart';
import 'package:global_error_handling/report_error.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String textContent = '';

  _metodoComErro() {
    throw ('teste de erro em método');
  }

  Future<String> _longFunction() async {
    await Future.delayed(Duration(seconds: 10), () {});
    return "Value";
  }

  Future<String> _errorOnFutureFunction() async {
    var teste;
    return Future.value(teste.message());
  }


  @override
  Widget build(BuildContext context) {
    EdgeInsets paddingEdges =
        const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0, right: 20.0);
    
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
                  child: Text('Timeout (Pure Dart error)'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: BorderSide(color: Colors.red)
                  ),
                  onPressed: () async {
                    await _longFunction().timeout(Duration(seconds: 1));
                  }),
            ),
            Container(
              padding: paddingEdges,
              width: double.infinity,
              child: RaisedButton(
                  child: Text('Future with then (Pure Dart error)'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: BorderSide(color: Colors.red)
                  ),
                  onPressed: () async {
                    _errorOnFutureFunction()
                        .then((value) => print('sucesso'));
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
}
