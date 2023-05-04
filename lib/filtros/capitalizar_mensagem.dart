import '../interfaces/imensagem.dart';
import '../interfaces/ioperacao.dart';

class CapitalizarMensagem implements IOperacao<IMensagem> {
  @override
  IMensagem executar(IMensagem input) {
    return capitalizarMensagem(input);
  }

  IMensagem capitalizarMensagem(IMensagem input) {
    String? textoMensagem = input.corpo;
    var textoCapitalizado = textoMensagem![0].toUpperCase();
    for (int i = 1; i < textoMensagem.length; i++) {
      if (textoMensagem[i - 1] == " ") {
        textoCapitalizado = textoCapitalizado + textoMensagem[i].toUpperCase();
      } else {
        textoCapitalizado = textoCapitalizado + textoMensagem[i];
      }
    }
    input.corpo = textoCapitalizado;
    input.isCapitalizado = true;
    return input;
  }
}
