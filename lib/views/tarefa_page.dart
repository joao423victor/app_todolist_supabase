import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/tarefa_controller.dart';
import '../services/auth_service.dart';
import '../services/pdf_service.dart';
import '../services/tarefa_service.dart';
import 'login_page.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  final AuthService _authService = AuthService();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final controller = TarefaController(
          TarefaService(),
          PdfService(),
        );
        controller.carregarTarefas();
        return controller;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Tarefas (To-Do)'),
          actions: [
            Consumer<TarefaController>(
              builder: (context, controller, child) {
                return IconButton(
                  icon: const Icon(Icons.picture_as_pdf),
                  tooltip: 'Exportar PDF',
                  onPressed: () async {
                    await controller.exportarPdf();

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('PDF gerado com sucesso.'),
                        ),
                      );
                    }
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Sair',
              onPressed: () async {
                await _authService.sair();

                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginPage(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        body: Consumer<TarefaController>(
          builder: (context, controller, child) {
            if (controller.carregando) {
              return const Center(child: CircularProgressIndicator());
            }

            final tarefasFiltradas = controller.tarefasFiltradas;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Buscar por título ou descrição',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (valor) {
                      context.read<TarefaController>().alterarTermoBusca(valor);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonFormField<FiltroTarefa>(
                    initialValue: controller.filtroAtual,
                    decoration: const InputDecoration(
                      labelText: 'Filtrar por status',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: FiltroTarefa.todas,
                        child: Text('Todas'),
                      ),
                      DropdownMenuItem(
                        value: FiltroTarefa.pendentes,
                        child: Text('Pendentes'),
                      ),
                      DropdownMenuItem(
                        value: FiltroTarefa.concluidas,
                        child: Text('Concluídas'),
                      ),
                    ],
                    onChanged: (filtro) {
                      if (filtro != null) {
                        context.read<TarefaController>().alterarFiltro(filtro);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: tarefasFiltradas.isEmpty
                      ? const Center(
                          child: Text('Nenhuma tarefa encontrada.'),
                        )
                      : ListView.builder(
                          itemCount: tarefasFiltradas.length,
                          itemBuilder: (context, index) {
                            final tarefa = tarefasFiltradas[index];

                            return ListTile(
                              title: Text(
                                tarefa.titulo,
                                style: TextStyle(
                                  decoration: tarefa.concluida
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              subtitle: Text(tarefa.descricao),
                              leading: Checkbox(
                                value: tarefa.concluida,
                                onChanged: (bool? value) {
                                  context
                                      .read<TarefaController>()
                                      .alternarStatusTarefa(tarefa);
                                },
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  context
                                      .read<TarefaController>()
                                      .deletarTarefa(tarefa.id!);
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () => _mostrarDialogoNovaTarefa(context),
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }

  void _mostrarDialogoNovaTarefa(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Nova Tarefa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                await context.read<TarefaController>().adicionarTarefa(
                      _tituloController.text,
                      _descricaoController.text,
                    );

                _tituloController.clear();
                _descricaoController.clear();

                if (dialogContext.mounted) {
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}