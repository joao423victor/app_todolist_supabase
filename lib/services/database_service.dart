import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
// Torna o construtor privado para evitar que a classe seja instanciada
DatabaseService._();
// Método estático responsável por inicializar a conexão com a nuvem
static Future<void> inicializar() async {
await Supabase.initialize(
url: 'https://blnoljpzlmjhydoiillu.supabase.co',
anonKey: 'sb_publishable_V-YPfts7KlEGWV3UIYYQnQ_rCSDj2iX',
);
}
}