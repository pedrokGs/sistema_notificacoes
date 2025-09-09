import 'dart:convert';

import 'package:http/http.dart' as http;

class NotificacaoService {
  // Endereço local do emulator (android stuio)  -> 10.0.2.2
  final String baseUrl = "http://10.0.2.2:8080";

  Future<String> enviarNotificacao(String mensagemId, String conteudo) async {
    final url = Uri.parse('$baseUrl/api/notificar');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'mensagemId': mensagemId,
        'conteudoMensagem': conteudo,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 202) {
      return 'AGUARDANDO_PROCESSAMENTO';
    } else {
      throw Exception("Erro ao enviar notificação");
    }

  }

  Future<String> consultarStatus(String mensagemId) async {
    final url = Uri.parse('$baseUrl/api/notificacao/status/$mensagemId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['status'];
    } else {
      return 'ERRO';
    }
  }
}
