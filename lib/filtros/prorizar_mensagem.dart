import '../interfaces/imensagem.dart';
import '../interfaces/ioperacao.dart';

class PriorizarMensagem implements IOperacao<IMensagem> {
  @override
  IMensagem executar(IMensagem input) {
    return _priorizar(input);
  }

  //prioritiza a mensagem
  IMensagem _priorizar(IMensagem input) {
    input.prioridade = 1;
    return (input);
  }
}
