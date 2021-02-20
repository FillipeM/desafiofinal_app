class Produto {
  int id;
  String descricao;
  String photoAddress;
  double valor;

  Produto(int id, String descricao, double valor)
      : this.id = id,
        this.descricao = descricao,
        this.valor = valor;

  Produto.fromJson(Map<String, dynamic> json, double vlr)
      : this.id = json["id"],
        this.descricao = json["title"],
        this.photoAddress = json["thumbnailUrl"],
        this.valor = vlr;

  Produto.fromJsonWithValue(Map<String, dynamic> json)
      : this.id = json["id"],
        this.descricao = json["title"],
        this.photoAddress = json["thumbnailUrl"],
        this.valor = json["vlr"];

  Map toJson() =>
      {
        "id": this.id,
        "title": this.descricao,
        "thumbnailUrl": this.photoAddress,
        "vlr": this.valor
      };
}
