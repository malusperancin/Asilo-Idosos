import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_mobile/data/api_services.dart';
import 'package:projeto_mobile/models/idoso_model.dart';
import 'dart:math';

class Idosos extends StatefulWidget {
  Idosos({Key key}) : super(key: key);
  @override
  _IdosoState createState() => _IdosoState();
}

class _IdosoState extends State<Idosos> {
  List<Idoso> idosos;
  Random random = new Random();

  getIdosos() {
    APIServices.buscarIdosos().then((response) {
      Iterable list = json.decode(response.body);
      List<Idoso> listaIdosos = [];
      listaIdosos = list.map((model) => Idoso.fromObject(model)).toList();
      setState(() {
        idosos = listaIdosos;
      });
    });
  }

  @override
  void initState() {
    getIdosos();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: idosos == null
            ? Center(
                child: Text('Não há nada por aqui...'),
              )
            : listaIdosos());
  }

  Widget listaIdosos() {
    return Stack(children: [
      Container(
          color: Colors.white,
          child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: ListView.builder(
                  itemCount: idosos.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Container(
                        color: Colors.grey[300],
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
                                            image: idosos[index].sexo ==
                                                    "Feminino"
                                                ? AssetImage(
                                                    "assets/images/idoso1.png")
                                                : AssetImage(
                                                    "assets/images/idoso2.png")))),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    idosos[index].nome,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto",
                                        fontSize: 20),
                                  ),
                                  Text(
                                    idosos[index].dataNascimento,
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontFamily: "Roboto",
                                        fontSize: 15),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      "RG: " + idosos[index].rg,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Roboto",
                                          fontSize: 17),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }))),
    ]);
  }
}
