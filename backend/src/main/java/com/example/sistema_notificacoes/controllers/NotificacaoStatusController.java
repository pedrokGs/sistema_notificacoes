package com.example.sistema_notificacoes.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.ConcurrentHashMap;
import java.util.Map;

@RestController
public class NotificacaoStatusController {

    private final Map<String, String> statusMensagens = new ConcurrentHashMap<>();

    public void atualizarStatus(String mensagemId, String status) {
        statusMensagens.put(mensagemId, status);
    }

    @GetMapping("/api/notificacao/status/{mensagemId}")
    public Map<String, String> consultarStatus(@PathVariable String mensagemId) {
        String status = statusMensagens.getOrDefault(mensagemId, "NAO_ENCONTRADO");
        Map<String, String> resposta = Map.of(
                "mensagemId", mensagemId,
                "status", status
        );
        return resposta;
    }
}
