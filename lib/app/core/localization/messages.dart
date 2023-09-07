import 'package:pcp_flutter/app/core/localization/enums/artigo_enum.dart';

abstract class Messages {
  String get avisoPesquisarPorNomeOuPalavraChave;
  String get avisoSemConexaoInternet;
  String get descatarAlteracoesCriacaoEntidade;
  String get descatarAlteracoesEdicaoEntidade;
  String get erroIdNaoInformado;
  String get erroCapacidadeMinimaMaiorTotal;
  String get erroCapacidadeMinimaMaiorMaxima;
  String get erroCapacidadeMaximaMaiorTotal;
  String get erroCapacidadeMaximaMenorMinima;
  String get errorCampoObrigatorio;
  String get mensagemAdicioneAsAperacoes;
  String get mensagemAdicioneUmaOperacao;
  String get mensagemAdicioneUmaOuMaisRestricoes;
  String get mensagemAdicioneUmRecurso;
  String get mensagemConfirmacaoDoRoteiro;
  String get mensagemComoCriarRoteiro;
  String get mensagemNaoEncontrouMaterial;
  String get mensagemSelecionePeriodoVigencia;
  String get mensagemSelecioneUmaUnidadeDeMedida;
  String get naoHaResultadosParaPesquisa;
  String get nenhumaDisponibilidadeFoiAdicionada;
  String get nenhumaIndisponibilidadeFoiAdicionada;
  String get nenhumHorarioFoiAdicionada;
  String get nenhumTurnoTrabalhoEncontrado;
  String get pesquisarNomeOuPalavraChave;
  String criouUmaEntidadeComSucesso(String entidade);
  String criouUmEntidadeComSucesso(String entidade);
  String editouUmaEntidadeComSucesso(String entidade);
  String editouUmEntidadeComSucesso(String entidade);
  String erroDadosIncompletoOuAusenteDaEntidade(String entidade);
  String erroDadosIncompletoOuAusenteDoEntidade(String entidade);
  String excluirUmaEntidade(String entidade);
  String excluirUmEntidade(String entidade);
  String excluiuUmaEntidadeComSucesso(String entidade);
  String excluiuUmEntidadeComSucesso(String entidade);
  String mensagemRemoverEntidade(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino});
  String nenhumaEntidadeEncontrada(String entidade);
  String nenhumEntidadeEncontrado(String entidade);
}
