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
      title: 'Lista de Clientes e Pets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Lista de Clientes e Pets'),
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
  List<Welcome> results = [];
  @override
  void initState() {
    setState(() {
      getResults();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
                'Clique no botão de Download para ver a Lista de Clientes e Pets',
                style: TextStyle(
                  fontSize: 20,
                )),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                title: Text(results[i].cliente),
                subtitle: Text(results[i].pet),
              );
            },
            itemCount: results.length,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.download_rounded),
        onPressed: () => {
          setState(() {
            getResults();
          })
        },
      ),
    );
  }

  getResults() async {
    results = await requisicao();
  }

  Future<List<Welcome>> requisicao() async {
    var url = 'http://192.168.192.26:3000/atendimentos';

    var response = await http.get(url);

    List<Welcome> welcomes;

    welcomes = (json.decode(response.body) as List)
        .map((i) => Welcome.fromJson(i))
        .toList();

    return welcomes;
  }
}
