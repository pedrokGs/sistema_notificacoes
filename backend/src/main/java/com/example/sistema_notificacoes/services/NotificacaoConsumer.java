package com.example.sistema_notificacoes.services;

import com.example.sistema_notificacoes.controllers.NotificacaoStatusController;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class NotificacaoConsumer {
    private final RabbitTemplate rabbitTemplate;
    private final NotificacaoStatusController statusController;

    public NotificacaoConsumer(RabbitTemplate rabbitTemplate, NotificacaoStatusController statusController) {
        this.rabbitTemplate = rabbitTemplate;
        this.statusController = statusController;
    }

    @RabbitListener(queues="fila.notificacao.entrada.pedro-henrique-goncalves")
    public void consumerMensagem(Map<String, String> mensagem) throws Exception{
        System.out.println(mensagem);

        //simulação
        Thread.sleep(2000);

        String mensagemId = mensagem.get("mensagemId");
        String status;

        try {
            status = "PROCESSADO_SUCESSO";
        } catch(Exception e) {
            status = "FALHA_PROCESSAMENTO";
        }

        statusController.atualizarStatus(mensagemId, status);

        // envia para a fila de status
        Map<String, String> statusMensagem = Map.of(
                "mensagemId", mensagemId,
                "status", status
        );

        rabbitTemplate.convertAndSend("fila.notificacao.status.pedro-henrique-goncalves", statusMensagem);
    }
}
