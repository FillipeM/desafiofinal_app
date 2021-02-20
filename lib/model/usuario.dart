class Usuario {
  int id;
  String nome;
  String login;
  String password;

  Usuario();

  Usuario.fromId(int id, String nome, String login, String password)
      : this.id = id,
        this.nome = nome,
        this.login = login,
        this.password = password;

  Usuario.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.nome = json["nome"],
        this.login = json["login"],
        this.password = json["password"];

  Map toJson() => {
        'id': this.id,
        'nome': this.nome,
        'login': this.login,
        'password': this.password
      };
}
