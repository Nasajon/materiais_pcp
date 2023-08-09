import 'package:pcp_flutter/app/core/localization/enums/artigo.dart';

abstract class Messages {
  String get avisoPesquisarPorNomeOuPalavraChave;
  String get avisoSemConexaoInternet;
  String get descatarAlteracoesCriacaoEntidade;
  String get descatarAlteracoesEdicaoEntidade;
  String get erroIdNaoInformado;
  String get errorCampoObrigatorio;
  String get naoHaResultadosParaPesquisa;
  String get nenhumaDisponibilidadeFoiAdicionada;
  String get nenhumaIndisponibilidadeFoiAdicionada;
  String get nenhumaFichaTecnicaEncontrada;
  String get nenhumHorarioFoiAdicionada;
  String get nenhumTurnoTrabalhoEncontrado;
  String get pesquisarNomeOuPalavraChave;
  String get nenhumMaterialFoiAdicionado;
  String criouUmaEntidadeComSucesso(String entidade, ArtigoEnum artigo);
  String criouAEntidadeComSucesso(String entidade, ArtigoEnum artigo);

  String editouUmaEntidadeComSucesso(String entidade, ArtigoEnum artigo);
  String editouAEntidadeComSucesso(String entidade, ArtigoEnum artigo);

  String erroDadosIncompletoOuAusenteDaEntidade(String entidade);
  String erroDadosIncompletoOuAusenteDoEntidade(String entidade);

  String excluirUmaEntidade(String entidade, ArtigoEnum artigo);
  String excluirAEntidade(String entidade, ArtigoEnum artigo);

  String excluiuUmaEntidadeComSucesso(String entidade, ArtigoEnum artigo);
  String excluiuAEntidadeComSucesso(String entidade, ArtigoEnum artigo);

  String nenhumaEntidadeEncontrada(String entidade);
  String nenhumEntidadeEncontrado(String entidade);

  String selecioneUm(String campo, ArtigoEnum artigo);
  String selecioneO(String campo, ArtigoEnum artigo);

  String insiraUm(String campo, ArtigoEnum artigo);
  String insiraO(String campo, ArtigoEnum artigo);
}
