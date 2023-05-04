import '../interfaces/imensagem.dart';
import '../interfaces/ioperacao.dart';

class CriptografarMensagem implements IOperacao<IMensagem> {
  //executa a operacao na mensagem
  @override
  IMensagem executar(IMensagem input) {
    return _criptografar(input);
  }

  //encripta a mensagem
  IMensagem _criptografar(IMensagem input) {
    String? textoMensagem = input.corpo;
    String textoCriptografado = '';
    int key = 2;

    for (int i = 0; i < textoMensagem!.length; i++) {
      String char = textoMensagem[i];

      if (char.toLowerCase() != char.toUpperCase()) {
        // Converter pra ASCII
        int ascii = char.codeUnitAt(0);

        // Aplica a chave no código ASCII
        ascii = (ascii + key) % 256;

        // Converter de volta
        char = String.fromCharCode(ascii);
      }
      textoCriptografado += char;
    }
    input.corpoCriptografado = textoCriptografado;
    input.isCriptografado = true;
    return (input);
  }
}
