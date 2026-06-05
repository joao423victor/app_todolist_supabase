import 'package:flutter/material.dart';
import '../models/tarefa.dart';
import '../services/tarefa_service.dart';
import '../services/pdf_service.dart';

enum FiltroTarefa {
  todas,
  pendentes,
  concluidas,
}

class TarefaController extends ChangeNotifier {
  final TarefaService _tarefaService;
  final PdfService _pdfService;

  TarefaController(
    this._tarefaService,
    this._pdfService,
  );

  List<Tarefa> _tarefas = [];
  List<Tarefa> get tarefas => _tarefas;

  FiltroTarefa _filtroAtual = FiltroTarefa.todas;
  FiltroTarefa get filtroAtual => _filtroAtual;

  String _termoBusca = '';
  String get termoBusca => _termoBusca;

  bool _carregando = false;
  bool get carregando => _carregando;

  List<Tarefa> get tarefasFiltradas {
    List<Tarefa> resultado = List.from(_tarefas);

    if (_filtroAtual == FiltroTarefa.pendentes) {
      resultado = resultado.where((tarefa) => !tarefa.concluida).toList();
    }

    if (_filtroAtual == FiltroTarefa.concluidas) {
      resultado = resultado.where((tarefa) => tarefa.concluida).toList();
    }

    if (_termoBusca.trim().isNotEmpty) {
      final termo = _termoBusca.toLowerCase();

      resultado = resultado.where((tarefa) {
        return tarefa.titulo.toLowerCase().contains(termo) ||
            tarefa.descricao.toLowerCase().contains(termo);
      }).toList();
    }

    return resultado;
  }

  void alterarFiltro(FiltroTarefa filtro) {
    _filtroAtual = filtro;
    notifyListeners();
  }

  void alterarTermoBusca(String termo) {
    _termoBusca = termo;
    notifyListeners();
  }

  Future<void> exportarPdf() async {
    await _pdfService.gerarPdf(tarefasFiltradas);
  }

  Future<void> carregarTarefas() async {
    _carregando = true;
    notifyListeners();

    _tarefas = await _tarefaService.obterTarefas();

    _carregando = false;
    notifyListeners();
  }

  Future<void> adicionarTarefa(String titulo, String descricao) async {
    if (titulo.trim().isEmpty) return;
    await _tarefaService.adicionarTarefa(titulo, descricao);
    await carregarTarefas();
  }

  Future<void> alternarStatusTarefa(Tarefa tarefa) async {
    await _tarefaService.alternarStatusTarefa(tarefa);
    await carregarTarefas();
  }

  Future<void> deletarTarefa(int id) async {
    await _tarefaService.deletarTarefa(id);
    await carregarTarefas();
  }
}