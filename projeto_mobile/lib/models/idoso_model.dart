class Idoso {
  int id;
  String rg;
  String nome;
  String dataNascimento;
  String sexo;

  Idoso(this.id, this.rg, this.nome, this.dataNascimento, this.sexo);

  Idoso.fromObject(dynamic o) {
    this.id = o["id"];
    this.rg = o["rg"];
    this.nome = o["nome"];
    this.dataNascimento = o["dataNascimento"];
    this.sexo = o["sexo"];
  }

  Map toJson() => {
        'id': id,
        'rg': rg,
        'nome': nome,
        'dataNascimento': dataNascimento,
        'sexo': sexo
      };
}
