package com.example.sistema_notificacoes.config;

import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitConfig {
    @Bean
    public Queue filaEntrada() {
        return new Queue("fila.notificacao.entrada.pedro-henrique-goncalves");
    }

    @Bean
    public Queue filaStatus(){ return new Queue("fila.notificacao.status.pedro-henrique-goncalves");}

    @Bean
    public Jackson2JsonMessageConverter jsonMessageConverter() {
        return new Jackson2JsonMessageConverter();
    }
}
