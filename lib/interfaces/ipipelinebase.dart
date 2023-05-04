import 'ioperacao.dart';

abstract class PipelineBase<T> {
  final List<IOperacao<T>> operacoes = [];

  PipelineBase<T> registrar(IOperacao<T> operacao) {
    operacoes.add(operacao);
    return this;
  }

  T performarOperacao(T input) {
    return operacoes.fold(
        input, (current, operation) => operation.executar(current));
  }
}
