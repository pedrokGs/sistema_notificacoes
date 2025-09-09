import 'package:flutter/material.dart';
import 'package:sistema_notificacoes/services/notificacao_service.dart';

class NotificacaoProvider extends ChangeNotifier{
  final NotificacaoService service = NotificacaoService();

  // mensagemId -> status
  Map<String, String> mensagens = {};

  void enviarNotificacao(String mensagemId, String conteudo) async{
    mensagens[mensagemId] = 'AGUARDANDO_PROCESSAMENTO';
    notifyListeners();

    try{
      await service.enviarNotificacao(mensagemId, conteudo);
      _atualizarStatusPeriodicamente(mensagemId);
    } catch(e){
      mensagens[mensagemId] = 'ERRO';
      notifyListeners();
    }
  }

  void _atualizarStatusPeriodicamente(String mensagemId) async{
    // Faz polling a cada 3 segundos
    while(mensagens[mensagemId] == 'AGUARDANDO_PROCESSAMENTO'){
      await Future.delayed(Duration(seconds: 3));
      try{
        final status = await service.consultarStatus(mensagemId);
        mensagens[mensagemId] = status;
        notifyListeners();

        if(status != 'AGUARDANDO_PROCESSAMENTO') break;
      } catch (e){
        mensagens[mensagemId] = 'ERRO';
        notifyListeners();
        break;
      }
    }
  }
}