import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_notificacoes/providers/notificacao_provider.dart';
import 'package:sistema_notificacoes/providers/theme_provider.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notificacaoProvider = Provider.of<NotificacaoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sistema de Notificações"),
        centerTitle: true,
        actions: [
          Consumer<ThemeProvider>(
            builder: (_, provider, _) {
              return IconButton(
                onPressed: provider.toggleTheme,
                icon: Icon(
                  provider.isDark ? Icons.dark_mode : Icons.light_mode,
                ),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                controller: _textController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo não pode estar vazio";
                  }
                  if (value.trim().length < 4) {
                    return "A notificação não pode ser tão curta";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () => _enviar(notificacaoProvider),
                child: Text("Enviar Notificação"),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Expanded(
                  child: Consumer<NotificacaoProvider>(
                    builder: (context, provider, _) {
                      final notificacoes = provider.mensagens.entries.toList();
                      if (notificacoes.isEmpty) {
                        return Center(child: Text("Nenhuma notificação ainda"));
                      }

                      return ListView.builder(
                        itemCount: notificacoes.length,
                        itemBuilder: (context, index) {
                          final notif = notificacoes[index];
                          final id = notif.key;
                          final status = notif.value;

                          return ListTile(
                            title: Text("ID: ${id}"),
                            subtitle: Text("Status: ${status}"),
                            trailing: Icon(
                              status == 'AGUARDANDO_PROCESSAMENTO'
                                  ? Icons.hourglass_top
                                  : status == 'ERRO'
                                  ? Icons.error
                                  : Icons.check_circle,
                              color: status == 'ERRO'
                                  ? Colors.red
                                  : status == 'AGUARDANDO_PROCESSAMENTO'
                                  ? Colors.orange
                                  : Colors.green,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _enviar(NotificacaoProvider provider) {
    if (_formKey.currentState!.validate()) {
      final String mensagemId = Uuid().v4();
      final String conteudo = _textController.text.trim();
      provider.enviarNotificacao(mensagemId, conteudo);

      _textController.clear();
    }
  }
}
