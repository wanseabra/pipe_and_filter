import 'package:pipe_and_filter/filtros/anexar_na_mensagem.dart';
import 'package:pipe_and_filter/filtros/assinar_mensagem.dart';

import 'filtros/capitalizar_mensagem.dart';
import 'filtros/criptografar_mensagem.dart';
import 'filtros/prorizar_mensagem.dart';
import 'interfaces/imensagem.dart';
import 'interfaces/ipipelinebase.dart';

class PipelineEnvio extends PipelineBase<IMensagem> {
  PipelineEnvio(List<String> filtros) {
    if (filtros.contains("criptografado")) {
      registrar(CriptografarMensagem());
    }
    if (filtros.contains("prioridade")) {
      registrar(PriorizarMensagem());
    }
    if (filtros.contains("capitalizado")) {
      registrar(CapitalizarMensagem());
    }
    if (filtros.contains("anexo")) {
      registrar(AnexarMensagem());
    }
    if (filtros.contains("assinatura")) {
      registrar(AssinarMensagem());
    }
  }
}
