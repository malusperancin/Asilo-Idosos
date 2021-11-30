import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_mobile/data/api_services.dart';
import 'package:projeto_mobile/models/horarios_model.dart';
import 'package:projeto_mobile/models/idoso_model.dart';
import 'package:projeto_mobile/ui/cabecalho.dart';
import 'dart:math';

import 'package:projeto_mobile/ui/idoso/idoso.dart';

class ListHorarios extends StatefulWidget {
  ListHorarios({Key key}) : super(key: key);
  @override
  _ListHorariosState createState() => _ListHorariosState();
}

class _ListHorariosState extends State<ListHorarios> {
  List<Horario> horarios;

  getHorarios() {
    APIServices.buscarHorariosRemedios().then((response) {
      Iterable list = json.decode(response.body);
      List<Horario> listaHorarios = [];
      listaHorarios = list.map((model) => Horario.fromObject(model)).toList();
      setState(() {
        horarios = listaHorarios;
      });
    });
  }

  @override
  void initState() {
    getHorarios();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: horarios == null
            ? Center(
                child: Text('Nenhum horario...'),
              )
            : listaHorarios());
  }

  Widget listaHorarios() {
    NumberFormat formatter = new NumberFormat("00");
    return Stack(children: [
      Cabecalho(
          cor: Colors.grey[200],
          titulo: "Agenda",
          icone: Icons.event_available_rounded),
      Expanded(
          child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: ListView.builder(
                  itemCount: horarios.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Container(
                          color: horarios[index].sexo == "Masculino"
                              ? Colors.blue[50]
                              : Colors.red[50],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                      width: 75.0,
                                      height: 75.0,
                                      decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/images/medicamento.png")))),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      horarios[index].idoso,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Roboto",
                                          fontSize: 20),
                                    ),
                                    Text(
                                      horarios[index].nome,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        formatter.format(horarios[index]
                                                .proximaData
                                                .day) +
                                            "/" +
                                            formatter.format(horarios[index]
                                                .proximaData
                                                .month) +
                                            "/" +
                                            horarios[index]
                                                .proximaData
                                                .year
                                                .toString() +
                                            " às " +
                                            formatter.format(horarios[index]
                                                .proximaData
                                                .hour) +
                                            "h" +
                                            formatter.format(horarios[index]
                                                .proximaData
                                                .minute),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 17),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ));
                  }))),
    ]);
  }
}
