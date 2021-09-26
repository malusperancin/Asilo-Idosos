import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projeto_mobile/data/api_services.dart';
import 'package:projeto_mobile/models/idoso_model.dart';
import 'package:projeto_mobile/models/remedio_model.dart';
import 'package:projeto_mobile/ui/home.dart';

class PerfilIdoso extends StatefulWidget {
  Idoso idoso;
  PerfilIdoso({Key key, this.idoso}) : super(key: key);

  @override
  _PerfilIdosoState createState() => _PerfilIdosoState();
}

class _PerfilIdosoState extends State<PerfilIdoso> {
  List<Remedio> remedios = [];

  Future<bool> fetchData() async {
    await APIServices.buscarRemedioIdoso(widget.idoso.rg).then((response) {
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        remedios = list.map((model) => Remedio.fromObject(model)).toList();
        print(remedios.length);
      } else {
        print(response.body);
      }
    });
    return true;
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String sexo = "";
    widget.idoso.sexo == "Feminino" ? sexo = "F" : sexo = "M";
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Column(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: sexo == "F"
                                  ? [Colors.redAccent, Colors.pinkAccent]
                                  : [
                                      Colors.lightBlueAccent[400],
                                      Colors.blueAccent[700]
                                    ])),
                      child: Container(
                        width: double.infinity,
                        height: 300.0,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(children: [
                                BackButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()),
                                    );
                                  },
                                  color: Colors.white,
                                ),
                                Spacer()
                              ]),
                              CircleAvatar(
                                backgroundImage: sexo == "F"
                                    ? AssetImage("assets/images/idoso1.png")
                                    : AssetImage("assets/images/idoso2.png"),
                                radius: 50.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                widget.idoso.nome,
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Card(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5.0),
                                clipBehavior: Clip.antiAlias,
                                color: Colors.white,
                                elevation: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Sexo",
                                              style: TextStyle(
                                                color: sexo == "F"
                                                    ? Colors.redAccent
                                                    : Colors.blue,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              widget.idoso.sexo,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Nascimento",
                                              style: TextStyle(
                                                color: sexo == "F"
                                                    ? Colors.redAccent
                                                    : Colors.blue,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              widget.idoso.dataNascimento,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "RG",
                                              style: TextStyle(
                                                color: sexo == "F"
                                                    ? Colors.redAccent
                                                    : Colors.blue,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              widget.idoso.rg,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Descrição:",
                            style: TextStyle(
                                color: sexo == "F"
                                    ? Colors.redAccent
                                    : Colors.blue,
                                fontStyle: FontStyle.normal,
                                fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Descrição sobre o idoso pode ser aqui.',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Expanded(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height / 2 - 61,
                            child: remedios.length == 0
                                ? Text(
                                    "Esse(a) idoso(a) não possui nenhum medicamento.")
                                : ListView.builder(
                                    itemCount: remedios.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Container(
                                          color: widget.idoso.sexo == "Feminino"
                                              ? Colors.red[100]
                                              : Colors.blue[100],
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      remedios[index].nome,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text(
                                                        remedios[index]
                                                            .descricao,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 17),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      remedios[index]
                                                              .proximaData
                                                              .day
                                                              .toString() +
                                                          "/" +
                                                          remedios[index]
                                                              .proximaData
                                                              .month
                                                              .toString() +
                                                          "/" +
                                                          remedios[index]
                                                              .proximaData
                                                              .year
                                                              .toString() +
                                                          " " +
                                                          remedios[index]
                                                              .proximaData
                                                              .hour
                                                              .toString() +
                                                          "h" +
                                                          remedios[index]
                                                              .proximaData
                                                              .minute
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text(
                                                        remedios[index]
                                                                .periodo
                                                                .toString() +
                                                            " em " +
                                                            remedios[index]
                                                                .periodo
                                                                .toString() +
                                                            " horas",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 17),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Spacer(),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 30),
                                                    child: Text(
                                                      remedios[index].cod,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }))),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
