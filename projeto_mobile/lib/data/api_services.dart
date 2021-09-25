import 'package:http/http.dart' as http;
import 'package:projeto_mobile/models/evento_model.dart';
import 'dart:convert';

class APIServices {
  static final String url = 'http://192.168.15.155:5000/api/';

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future buscarIdosos() async {
    return await http.get(Uri.parse(url + 'idoso'));
  }
    static Future buscarIdosoPorId(int id) async {
    return await http.get(Uri.parse(url + 'idoso/' + id.toString()));
  }


  static Future buscarRemedios() async {
    return await http.get(Uri.parse(url + 'remedio'));
  }

  static Future buscarRemedioIdoso() async {
    return await http.get(Uri.parse(url + 'equipes'));
  }


/*
  static Future<bool> adicionarEvento(Evento evento) async {
    var resultado = await http.post(Uri.parse(url + "eventos"),
        headers: header, body: json.encode(evento.toJson()));
    return Future.value(resultado.statusCode == 200 ? true : false);
  }

  static Future editarEvento(Evento evento) async {
    return await http.put(Uri.parse(url + 'eventos/' + evento.id.toString()),
        headers: header, body: json.encode(evento.toJson()));
  }

  static Future<bool> deletarEvento(Evento evento) async {
    var resultado =
        await http.delete(Uri.parse(url + 'eventos/' + evento.id.toString()));
    return Future.value(resultado.statusCode == 200 ? true : false);
  }*/
}
