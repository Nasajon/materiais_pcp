import 'package:pcp_flutter/app/core/localization/artigos_enum.dart';

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
  String criouUmaEntidadeComSucesso(String entidade);
  String criouUmEntidadeComSucesso(String entidade);
  String criouEntidadeComSucesso(String entidade, ArtigoEnum artigo);

  String editouUmaEntidadeComSucesso(String entidade);
  String editouUmEntidadeComSucesso(String entidade);
  String editouEntidadeComSucesso(String entidade, ArtigoEnum artigo);

  String erroDadosIncompletoOuAusenteDaEntidade(String entidade);
  String erroDadosIncompletoOuAusenteDoEntidade(String entidade);

  String excluirUmaEntidade(String entidade);
  String excluirUmEntidade(String entidade);
  String excluirEntidade(String entidade, ArtigoEnum artigo);

  String excluiuUmaEntidadeComSucesso(String entidade);
  String excluiuUmEntidadeComSucesso(String entidade);
  String excluiuEntidadeComSucesso(String entidade, ArtigoEnum artigo);

  String nenhumaEntidadeEncontrada(String entidade);
  String nenhumEntidadeEncontrado(String entidade);

  String selecione(String campo, ArtigoEnum artigo);

  String insira(String campo, ArtigoEnum artigo);
}
