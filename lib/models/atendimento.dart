// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  Welcome({
    this.id,
    this.cliente,
    this.pet,
    this.servico,
    this.data,
    this.dataCriacao,
    this.status,
    this.observacoes,
  });

  int id;
  String cliente;
  String pet;
  String servico;
  DateTime data;
  DateTime dataCriacao;
  String status;
  String observacoes;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["id"],
        cliente: json["cliente"],
        pet: json["pet"],
        servico: json["servico"],
        data: DateTime.parse(json["data"]),
        dataCriacao: DateTime.parse(json["dataCriacao"]),
        status: json["status"],
        observacoes: json["observacoes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cliente": cliente,
        "pet": pet,
        "servico": servico,
        "data": data.toIso8601String(),
        "dataCriacao": dataCriacao.toIso8601String(),
        "status": status,
        "observacoes": observacoes,
      };
}
