package com.example.sistema_notificacoes;

import com.example.sistema_notificacoes.controllers.NotificacaoController;
import org.junit.jupiter.api.Test;
import org.springframework.http.ResponseEntity;
import org.springframework.amqp.rabbit.core.RabbitTemplate;

import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

class NotificacaoControllerTest {

    // Classe fake para substituir o template
    static class FakeRabbitTemplate extends RabbitTemplate {
        Map<String, Object> ultimoEnvio = new HashMap<>();

        @Override
        public void convertAndSend(String exchange, Object message) {
            ultimoEnvio.put(exchange, message);
        }
    }

    @Test
    void testNotificar() {
//        FakeRabbitTemplate fakeRabbit = new FakeRabbitTemplate();
//        NotificacaoController controller = new NotificacaoController(fakeRabbit);
//
//        // Mensagem teste
//        Map<String, String> mensagem = new HashMap<>();
//        mensagem.put("mensagemId", "123");
//        mensagem.put("conteudoMensagem", "Olá mundo");
//
//        ResponseEntity<String> response = controller.notificar(mensagem);
//
//        // Testa status HTTP
//        assertEquals(202, response.getStatusCode().value());
//
//        // Testa corpo da resposta
//        assertTrue(response.getBody().contains("recebido"));
//        assertTrue(response.getBody().contains("123"));
//
//        // Testa se foi enviada pelo template fake
//        assertEquals(
//                mensagem,
//                fakeRabbit.ultimoEnvio.get("fila.notificacao.entrada.pedro-henrique-goncalves")
//        );
    }
}
