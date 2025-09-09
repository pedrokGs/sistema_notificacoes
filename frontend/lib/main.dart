import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_notificacoes/providers/notificacao_provider.dart';
import 'package:sistema_notificacoes/providers/theme_provider.dart';
import 'package:sistema_notificacoes/screens/home_page.dart';

void main() {
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider<NotificacaoProvider>(create: (context) => NotificacaoProvider(),),
        ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider(),)
      ], child: SistemaNotificacoesApp(),)
  );
}

class SistemaNotificacoesApp extends StatelessWidget {
  const SistemaNotificacoesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'SistemaNotificações',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
      },
    );
  }
}