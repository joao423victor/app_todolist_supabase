import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/tarefa.dart';

class PdfService {
  Future<void> gerarPdf(List<Tarefa> tarefas) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Relatório de Tarefas',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 12),
              pw.Text('Total de registros: ${tarefas.length}'),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: const [
                  'Título',
                  'Descrição',
                  'Status',
                ],
                data: tarefas.map((tarefa) {
                  return [
                    tarefa.titulo,
                    tarefa.descricao,
                    tarefa.concluida ? 'Concluída' : 'Pendente',
                  ];
                }).toList(),
              ),
            ],
          );
        },
      ),
    );

    final bytes = await pdf.save();

    if (kIsWeb) {
      await Printing.sharePdf(
        bytes: bytes,
        filename: 'relatorio_tarefas.pdf',
      );
    } else {
      await Printing.sharePdf(
        bytes: bytes,
        filename: 'relatorio_tarefas.pdf',
      );
    }
  }
}