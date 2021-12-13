class SecureContact {
  late final String nome;
  late final String telefone;

  SecureContact(this.nome, this.telefone);

  SecureContact.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    telefone = json['telefone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['telefone'] = telefone;
    return data;
  }
}
