import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
// Torna o construtor privado para evitar que a classe seja instanciada
DatabaseService._();
// Método estático responsável por inicializar a conexão com a nuvem
static Future<void> inicializar() async {
await Supabase.initialize(
  url: dotenv.env['SUPABASE_URL']!,
  anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
);
}
}