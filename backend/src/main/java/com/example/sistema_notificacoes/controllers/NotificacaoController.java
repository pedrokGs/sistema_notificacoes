package com.example.sistema_notificacoes.controllers;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class NotificacaoController {

    private final RabbitTemplate rabbitTemplate;

    public NotificacaoController(RabbitTemplate rabbitTemplate) {
        this.rabbitTemplate = rabbitTemplate;
    }

    // metodo post aceita um map contendo mensagemId & conteudoMensagem, envia mensagem para fila de entrada e retorna resposta HTTP
    @PostMapping("/notificar")
    public ResponseEntity<Map<String, String>> notificar(@RequestBody Map<String, String> mensagem) {
        rabbitTemplate.convertAndSend("fila.notificacao.entrada.pedro-henrique-goncalves", mensagem);

        Map<String, String> resposta = new HashMap<>();
        resposta.put("status", "recebido");
        resposta.put("mensagemId", mensagem.get("mensagemId"));

        return ResponseEntity.status(HttpStatus.ACCEPTED).body(resposta);
    }

}
