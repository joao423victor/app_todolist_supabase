import 'package:flutter/material.dart';
import 'services/database_service.dart';
import 'views/tarefa_page.dart';
import 'views/login_page.dart';
//instalar as dependências
//flutter pub get

void main() async {
  // Garante que os widgets do Flutter estejam inicializados antes de rodar qualquer código nativo
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.inicializar();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}