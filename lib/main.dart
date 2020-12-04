import 'package:api_atendimentos_mobile/models/atendimento.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future request;
  @override
  void initState() {
    request = requisicao();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<Welcome>(
        builder: (BuildContext context, AsyncSnapshot<Welcome> snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            return ListTile(title: Text(snapshot.data.cliente[0]));
          }
          return CircularProgressIndicator();
        },
        future: request,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => {request = requisicao()},
      ),
    );
  }

  Future<Welcome> requisicao() async {
    var url = 'http://192.168.192.26:3000/atendimentos';
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var result = json.decode(response.body);
    var teste = Welcome.fromJson(result);

    print(teste.id);

    return teste;
  }
}
