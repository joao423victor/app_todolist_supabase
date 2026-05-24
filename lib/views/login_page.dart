import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'tarefa_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authService = AuthService();

  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _carregando = false;

  @override
  void initState() {
    super.initState();

    _authService.authStateChanges.listen((data) {
      final session = data.session;

      if (session != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TarefaPage()),
        );
      }
    });
  }

  Future<void> _entrar() async {
    setState(() => _carregando = true);

    try {
      await _authService.entrar(
        email: _emailController.text.trim(),
        senha: _senhaController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TarefaPage()),
      );
    } catch (e) {
      _mostrarMensagem('Erro ao entrar: $e');
    } finally {
      if (mounted) {
        setState(() => _carregando = false);
      }
    }
  }

  Future<void> _cadastrar() async {
    setState(() => _carregando = true);

    try {
      await _authService.cadastrar(
        email: _emailController.text.trim(),
        senha: _senhaController.text.trim(),
      );

      _mostrarMensagem(
        'Cadastro realizado. Verifique seu e-mail antes do primeiro acesso.',
      );
    } catch (e) {
      _mostrarMensagem('Erro ao cadastrar: $e');
    } finally {
      if (mounted) {
        setState(() => _carregando = false);
      }
    }
  }

  Future<void> _entrarComGoogle() async {
    try {
      await _authService.entrarComGoogle();
    } catch (e) {
      _mostrarMensagem('Erro no login com Google: $e');
    }
  }

  void _mostrarMensagem(String mensagem) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acesso ao To-Do List'),
      ),
      body: Center(
        child: SizedBox(
          width: 360,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                if (_carregando)
                  const CircularProgressIndicator()
                else ...[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _entrar,
                      child: const Text('Entrar'),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _cadastrar,
                      child: const Text('Cadastrar'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _entrarComGoogle,
                      child: const Text('Entrar com Google'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}