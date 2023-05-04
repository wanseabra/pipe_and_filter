import '../interfaces/imensagem.dart';
import '../interfaces/ioperacao.dart';

class AnexarMensagem implements IOperacao<IMensagem> {
  @override
  IMensagem executar(IMensagem input) {
    return _anexar(input);
  }

  IMensagem _anexar(IMensagem input) {
    input.anexo = 1;
    return (input);
  }
}
