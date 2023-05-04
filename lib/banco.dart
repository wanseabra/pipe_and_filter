// ignore_for_file: unused_field

import 'dart:math';

import 'interfaces/imensagem.dart';

class Requisicao {
  final String texto;
  int prioridade;
  bool isCriptografado;
  bool isCapitalizado;
  int anexo;
  int assinatura;

  Requisicao(this.texto, this.prioridade, this.isCriptografado,
      this.isCapitalizado, this.anexo, this.assinatura);
}

class RequisicaoBrain {
  final List<Requisicao> _requisicaoBank = [
    //prioridade, criptografado, capitalizado, anexo e assinatura
    Requisicao(
        "Preciso que:\n•Minha mensagem seja criptografada\n•Caixa alta!\n•Ela é prioridade!",
        1, //prioridade
        true, //criptografado
        true, //capitalizado
        0, //anexado
        0), //assinado
    Requisicao(
        "Quero que mande uma mensagem:\n•Prioritária\n•Assinada\n•Com caixa alta",
        1, //prioridade
        false, //criptografado
        true, //capitalizado
        0, //anexado
        1), //assinado
    Requisicao(
        "Seria legal uma mensagem...\n•Assinada\n•Com Anexo\n•Criptografada!",
        0, //prioridade
        true, //criptografado
        false, //capitalizado
        1, //anexado
        1), //assinado
    Requisicao(
        "Quero que envie essa mensagem prioritária:\n•Com anexo\n•Assinada",
        1, //prioridade
        false, //criptografado
        false, //capitalizado
        1, //anexado
        1), //assinado
    Requisicao(
        "Me faz um favor, mande uma mensagem:\n•Prioritária\n•Assinada\n•Com caixa alta",
        1, //prioridade
        false, //criptografado
        true, //capitalizado
        0, //anexado
        1), //assinado
    Requisicao(
        "Rápido, mande uma mensagem:\n•Capitalizada\n•Assinada\n•Com anexo!",
        0, //prioridade
        false, //criptografado
        true, //capitalizado
        1, //anexado
        0), //assinado
    Requisicao(
        "Preciso de uma mensagem prioritária:\n•Com anexo\n•Assinada",
        1, //prioridade
        false, //criptografado
        false, //capitalizado
        1, //anexado
        1),
    Requisicao(
        "Preciso que minha mensagem seja criptografada:\n•Caixa alta!\n•Com prioridade!",
        1, //prioridade
        true, //criptografado
        true, //capitalizado
        0, //anexado
        0), //assinado
  ];

  Requisicao pegarRequisicao() {
    return _requisicaoBank[Random().nextInt(_requisicaoBank.length)];
  }

  bool checkMensagem(IMensagem mensagem, Requisicao requisicao) {
    int value = 0;
    if (mensagem.prioridade != requisicao.prioridade) value++;
    if (mensagem.isCriptografado != requisicao.isCriptografado) value++;
    if (mensagem.isCapitalizado != requisicao.isCapitalizado) value++;
    if (mensagem.anexo != requisicao.anexo) value++;
    if (mensagem.assinatura != requisicao.assinatura) value++;
    if (value != 0) return false;
    return true;
  }
}
