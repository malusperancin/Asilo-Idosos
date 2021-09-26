class Horario {
  DateTime proximaData;
  int periodo;
  String cod;
  String nome;
  String descricao;
  String idoso;
  String sexo;

  Horario(this.proximaData, this.periodo, this.cod, this.nome, this.descricao,
      this.idoso, this.sexo);

  Horario.fromObject(dynamic o) {
    var proximaData = o[0].split("T")[0].split("-");
    var proximaHora = o[0].split("T")[1].split(":");
    this.proximaData = new DateTime(
        int.parse(proximaData[0]),
        int.parse(proximaData[1]),
        int.parse(proximaData[2]),
        int.parse(proximaHora[0]),
        int.parse(proximaHora[1]));
    this.periodo = o[1];
    this.cod = o[2];
    this.nome = o[3];
    this.descricao = o[4];
    this.idoso = o[5];
    this.sexo = o[6];
  }

  Map toJson() => {
        'proximaData': proximaData.toIso8601String(),
        'periodo': periodo,
        'cod': cod,
        'nome': nome,
        'descricao': descricao,
        'idoso': nome,
        'sexo': descricao
      };
}
