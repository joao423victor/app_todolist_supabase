// lib/services/tarefa_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tarefa.dart';

class TarefaService {

  final _client = Supabase.instance.client;

  String get _userId {
    final user = _client.auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado.');
    }

    return user.id;
  }

  Future<List<Tarefa>> obterTarefas() async {
    final response = await _client
        .from('tarefas')
        .select()
        .eq('user_id', _userId)
        .order('id', ascending: true);

    return response.map((item) => Tarefa.fromMap(item)).toList();
  }

  Future<void> adicionarTarefa(String titulo, String descricao) async {
    final novaTarefa = Tarefa(
      titulo: titulo,
      descricao: descricao,
    );

    final dados = novaTarefa.toMap();
    dados['user_id'] = _userId;

    await _client.from('tarefas').insert(dados);
  }

  Future<void> alternarStatusTarefa(Tarefa tarefa) async {
    tarefa.concluida = !tarefa.concluida;

    await _client
        .from('tarefas')
        .update({
          'concluida': tarefa.concluida,
        })
        .eq('id', tarefa.id!)
        .eq('user_id', _userId);
  }

  Future<void> deletarTarefa(int id) async {
    await _client
        .from('tarefas')
        .delete()
        .eq('id', id)
        .eq('user_id', _userId);
  }
}