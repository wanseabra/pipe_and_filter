import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:pipe_and_filter/banco.dart';
import 'package:pipe_and_filter/score_screen.dart';
import 'package:pipe_and_filter/widgets.dart';
import 'gerar_mensagem.dart';
import 'interfaces/imensagem.dart';

enum FiltroMensagem {
  prioridade,
  criptografado,
  anexo,
  assinatura,
  capitalizado
}

const duracao = 30;

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PipeFilterHome();
  }
}

class PipeFilterHome extends StatefulWidget {
  const PipeFilterHome({super.key});

  @override
  State<PipeFilterHome> createState() => _PipeFilterHomeState();
}

class _PipeFilterHomeState extends State<PipeFilterHome>
    with SingleTickerProviderStateMixin {
  //variaveis e afins de UI e animacao
  final _textController = TextEditingController();
  late AnimationController controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500));
  late Animation<Offset> tileAnimationOffset =
      Tween<Offset>(begin: const Offset(-600, 0), end: const Offset(0, 0))
          .animate(controller);

  //variaveis do jogo
  IMensagem? mensagemUser;
  final List<String> filtros = <String>[];
  bool middle = false;
  int score = 0;
  final brain = RequisicaoBrain();
  late Requisicao requisicaoEscolhida = brain.pegarRequisicao();
  int avatar = Random().nextInt(4);

  @override
  void initState() {
    super.initState();
    setAnimacao(meio: false);
    controller.forward();
    middle = true;
  }

  void setAnimacao({required bool meio}) {
    final desaparecer =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(600, 0))
            .animate(controller);

    final aparecer =
        Tween<Offset>(begin: const Offset(-600, 0), end: const Offset(0, 0))
            .animate(controller);

    tileAnimationOffset = meio ? desaparecer : aparecer;
  }

  @override
  void dispose() {
    _textController.dispose();
    controller.dispose();
    super.dispose();
  }

  void mover() {
    setAnimacao(meio: middle);
    controller.reset();
    controller.forward();
    middle = !middle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //quando o timer acabar, ele vai pra tela de score
              LinearTimer(
                minHeight: 15,
                color: Colors.red,
                duration: const Duration(seconds: duracao),
                onTimerEnd: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScoreScreen(
                              score: score,
                            )),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  AnimatedBuilder(
                      animation: tileAnimationOffset,
                      child: MensagemRequest(
                        avatar: avatar,
                        requests: requisicaoEscolhida.texto,
                        //titulo: requisicaoEscolhida.titulo,
                      ),
                      builder: (ctx, child) {
                        return Transform.translate(
                          offset: tileAnimationOffset.value,
                          child: child!,
                        );
                      }),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 1),
                      child: Text(
                        "Mensagem a ser enviada:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            requisicaoEscolhida.mensagem,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.red),
                          ),
                        ),
                      )),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Selecione os filtros clicando nos botões abaixo!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children:
                        FiltroMensagem.values.map((FiltroMensagem filtro) {
                      return FilterChip(
                          label: Text(
                            filtro.name,
                            style: const TextStyle(fontSize: 15),
                          ),
                          selected: filtros.contains(filtro.name),
                          onSelected: (bool value) {
                            setState(() {
                              if (value) {
                                if (!filtros.contains(filtro.name)) {
                                  filtros.add(filtro.name);
                                }
                              } else {
                                filtros.removeWhere((String name) {
                                  return name == filtro.name;
                                });
                              }
                            });
                          });
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                      onTap: () {
                        setState(() {
                          mensagemUser = gerarMensagem(
                              requisicaoEscolhida.mensagem, filtros);
                          if (brain.checkMensagem(
                              mensagemUser!, requisicaoEscolhida)) score++;
                          mover(); //mover pra fora da tela
                          _textController.clear();
                          filtros.clear();
                          requisicaoEscolhida = brain.pegarRequisicao();
                          avatar = Random().nextInt(4);
                          Future.delayed(const Duration(milliseconds: 10), () {
                            mover();
                          });
                        });
                        //return FocusScope.of(context).unfocus();
                        // } else {
                        //   Fluttertoast.showToast(
                        //       msg: "O campo de texto está vazio",
                        //       toastLength: Toast.LENGTH_SHORT,
                        //       gravity: ToastGravity.BOTTOM,
                        //       fontSize: 16.0);
                        // }
                      },
                      label: "Enviar a mensagem!"),
                  if (mensagemUser != null)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: RichText(
                            text: TextSpan(
                                text: "Dados da mensagem:\n",
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                children: [
                              const TextSpan(
                                  text: "Corpo da mensagem: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                              TextSpan(
                                  text: "${mensagemUser!.corpo}.\n",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              if (mensagemUser!.isMensagemCriptografada()) ...[
                                const TextSpan(
                                    text: "Corpo da mensagem (criptografado): ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal)),
                                TextSpan(
                                    text:
                                        "${mensagemUser!.corpoCriptografado}.\n",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                              const TextSpan(
                                  text: "A mensagem tem prioridade? ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                              TextSpan(
                                  text:
                                      "${mensagemUser!.isMensagemPrioritaria() ? "Sim" : "Não"}\n",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          mensagemUser!.isMensagemPrioritaria()
                                              ? Colors.green[700]
                                              : Colors.black)),
                              const TextSpan(
                                  text: "A mensagem tem anexo? ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                              TextSpan(
                                  text: "Tem ${mensagemUser!.anexo} anexo.\n",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(
                                  text: "A mensagem tem assinatura? ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                              TextSpan(
                                  text:
                                      "Tem ${mensagemUser!.assinatura} assinatura.\n",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ])),
                      ),
                    ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
