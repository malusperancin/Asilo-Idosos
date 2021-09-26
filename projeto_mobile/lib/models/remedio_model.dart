class Remedio {
  int id;
  String cod;
  String nome;
  String descricao;
  DateTime dataInicio;
  DateTime proximaData;
  int periodo;

  Remedio(this.id, this.cod, this.nome, this.descricao, this.dataInicio,
      this.proximaData, this.periodo);

  Remedio.fromObject(dynamic o) {
    this.id = o[0];
    this.cod = o[1];
    this.nome = o[2];
    this.descricao = o[3];
    var dataInicio = o[4].split("T")[0].split("-");
    var horaInicio = o[4].split("T")[1].split(":");
    this.dataInicio = new DateTime(
        int.parse(dataInicio[0]),
        int.parse(dataInicio[1]),
        int.parse(dataInicio[2]),
        int.parse(horaInicio[0]),
        int.parse(horaInicio[1]));
    var proximaData = o[5].split("T")[0].split("-");
    var proximaHora = o[5].split("T")[1].split(":");
    this.proximaData = new DateTime(
        int.parse(proximaData[0]),
        int.parse(proximaData[1]),
        int.parse(proximaData[2]),
        int.parse(proximaHora[0]),
        int.parse(proximaHora[1]));
    this.periodo = o[6];
  }

  Map toJson() => {
        'id': id,
        'cod': cod,
        'nome': nome,
        'descricao': descricao,
        'dataInicio': dataInicio.toIso8601String(),
        'proximaData': proximaData.toIso8601String(),
        'periodo': periodo
      };
}
