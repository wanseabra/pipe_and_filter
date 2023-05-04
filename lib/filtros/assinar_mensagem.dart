import '../interfaces/imensagem.dart';
import '../interfaces/ioperacao.dart';

class AssinarMensagem implements IOperacao<IMensagem> {
  @override
  IMensagem executar(IMensagem input) {
    return _assinar(input);
  }

  IMensagem _assinar(IMensagem input) {
    input.assinatura = 1;
    return (input);
  }
}
