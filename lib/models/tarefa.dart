class Tarefa {
  int? id; //pode ser nulo
  String titulo;
  String descricao;
  bool concluida;

  Tarefa({
    this.id,
    required this.titulo,
    required this.descricao,
    this.concluida = false,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'concluida': concluida,
    };
  }

  factory Tarefa.fromMap(Map<String, dynamic> mapa) {
    return Tarefa(
      id: mapa['id'],
      titulo: mapa['titulo'],
      descricao: mapa['descricao'],
      // Aceita tanto booleano nativo quanto o fallback antigo caso necessário
      concluida:mapa['concluida'] is bool ? mapa['concluida'] : mapa['concluida']==1,
    );
  }
}