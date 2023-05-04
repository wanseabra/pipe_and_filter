import 'package:flutter/material.dart';
import 'package:pipe_and_filter/main_screen.dart';
import 'package:pipe_and_filter/utils.dart';
import 'package:pipe_and_filter/widgets.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: primaryBlack),
      home: const StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                    "Pipe and Filter",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 35, top: 3),
                  child: Text(
                    "Demonstração da arquitetura Pipe and Filter",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: Image.asset("assets/images/mail.png")),
                const Spacer(),
                const Text(
                  "\nComo jogar?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  "\n• Usuários chegarão com suas requisições e você precisa atendê-las;",
                  style: textStyle(),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "\n• Leia as requisições, marque os filtros conforme necessário e envie a mensagem;",
                  style: textStyle(),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "\n• Envie o máximo de mensagens que conseguir no tempo!",
                  style: textStyle(),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "\nSeu score ficará disponível no final.",
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CustomButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()),
                        );
                      },
                      label: "Iniciar o jogo"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
