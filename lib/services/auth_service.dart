import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {

  final _client = Supabase.instance.client;

  User? get usuarioAtual => _client.auth.currentUser;

  Stream<AuthState> get authStateChanges =>
      _client.auth.onAuthStateChange;

  Future<void> cadastrar({
    required String email,
    required String senha,
  }) async {

    await _client.auth.signUp(
      email: email,
      password: senha,
    );

  }

  Future<void> entrar({
    required String email,
    required String senha,
  }) async {

    await _client.auth.signInWithPassword(
      email: email,
      password: senha,
    );

  }

  Future<void> sair() async {

    await _client.auth.signOut();

  }

  Future<void> entrarComGoogle() async {

    await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'http://localhost:50868',
    );

  }

}