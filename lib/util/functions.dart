import 'dart:convert';
import 'package:http/http.dart' as http;
class Functions {
  static int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  static String safeErrorMessage(http.Response r) {
    // 1) se o servidor sinaliza JSON no header, tente decodificar com segurança
    final ct = r.headers['content-type'] ?? '';
    if (ct.contains('application/json')) {
      final m = _tryParseJson(r.body);
      final msg = m?['message'] ?? m?['error_description'] ?? m?['error'];
      if (msg is String && msg.trim().isNotEmpty) return msg;
    }

    // 2) códigos comuns
    if (r.statusCode == 401)
      return 'Status 401';
    if (r.statusCode == 403) return 'Status 403';
    if (r.statusCode >= 500) return 'Erro no servidor (${r.statusCode}).';

    // 3) fallback
    return 'Erro ${r.statusCode}: ${r.reasonPhrase ?? 'Falha na requisição.'}';
  }

  static Map<String, dynamic>? _tryParseJson(String body) {
    if (body.isEmpty) return null;
    try {
      final v = jsonDecode(body);
      return v is Map<String, dynamic> ? v : null;
    } catch (_) {
      return null;
    }
  }
}
