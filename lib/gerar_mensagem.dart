import 'package:pipe_and_filter/pipelineEnvio.dart';
import 'interfaces/imensagem.dart';
import 'mensagem.dart';

IMensagem gerarMensagem(String msg, List<String> filtros) {
  IMensagem message = Mensagem(corpo: msg);
  PipelineEnvio pipelineEnvio = PipelineEnvio(filtros);
  return pipelineEnvio.performarOperacao(message);
}
