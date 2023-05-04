import 'interfaces/imensagem.dart';

class Mensagem implements IMensagem {
  @override
  int prioridade = 0;
  @override
  bool isCriptografado = false;
  @override
  String? corpoCriptografado;
  @override
  String? corpo;
  @override
  int anexo = 0;
  @override
  int assinatura = 0;
  @override
  bool isCapitalizado = false;

  @override
  bool isMensagemCriptografada() {
    return isCriptografado;
  }

  @override
  bool isMensagemPrioritaria() {
    return (prioridade != 0);
  }

  Mensagem({this.corpo});

  @override
  bool hasAnexo() {
    return (anexo != 0);
  }

  @override
  bool hasAssinatura() {
    return (assinatura != 0);
  }

  @override
  bool isMensagemCapitalizado() {
    return isCapitalizado;
  }
}
