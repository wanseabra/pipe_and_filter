abstract class IMensagem {
  late int prioridade;
  late bool isCriptografado;
  late bool isCapitalizado;
  late int anexo;
  late int assinatura;
  String? corpoCriptografado;
  String? corpo;

  bool isMensagemPrioritaria();
  bool isMensagemCriptografada();
  bool isMensagemCapitalizado();
  bool hasAnexo();
  bool hasAssinatura();
}
