import 'package:pcp_flutter/app/core/localization/enums/artigo_enum.dart';

abstract class Messages {
  String get avisoPesquisarPorNomeOuPalavraChave;
  String get avisoSemConexaoInternet;
  String get descatarAlteracoesCriacaoEntidade;
  String get descatarAlteracoesEdicaoEntidade;
  String get erroCapacidadeMaximaMaiorTotal;
  String get erroCapacidadeMaximaMenorMinima;
  String get erroCapacidadeMinimaMaiorMaxima;
  String get erroCapacidadeMinimaMaiorTotal;
  String get erroIdNaoInformado;
  String get erroNaoHaRoteiroParaProdutoSelecionado;
  String get errorCampoObrigatorio;
  String get erroSelecioneUmProdutoAntes;
  String get mensagemAdicioneAsAperacoes;
  String get mensagemAdicioneUmaOperacao;
  String get mensagemAdicioneUmaOuMaisRestricoes;
  String get mensagemAdicioneUmRecurso;
  String get mensagemApontamentoChaoDeFabrica;
  String get mensagemComoCriarRoteiro;
  String get mensagemConfirmacaoDoRoteiro;
  String get mensagemNaoEncontrouMaterial;
  String get mensagemSelecionePeriodoVigencia;
  String get mensagemSelecioneUmaUnidadeDeMedida;
  String get naoHaResultadosParaPesquisa;
  String get nenhumaDisponibilidadeFoiAdicionada;
  String get nenhumaFichaTecnicaEncontrada;
  String get nenhumaIndisponibilidadeFoiAdicionada;
  String get nenhumHorarioFoiAdicionada;
  String get nenhumMaterialFoiAdicionado;
  String get nenhumTurnoTrabalhoEncontrado;
  String get pesquisarNomeOuPalavraChave;
  String get selecioneRoteiroExibirOperacoes;

  String criouAEntidadeComSucesso(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino});

  String criouUmaEntidadeComSucesso(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino});

  String editouAEntidadeComSucesso(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino});

  String editouUmaEntidadeComSucesso(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino});
  String erroDadosIncompletoOuAusenteDaEntidade(String entidade);

  String erroDadosIncompletoOuAusenteDoEntidade(String entidade);
  String excluirAEntidade(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino});

  String excluirUmaEntidade(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino});

  String excluiuAEntidadeComSucesso(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino});
  String excluiuUmaEntidadeComSucesso(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino});

  String insiraO(String campo, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino});
  String insiraUm(String campo, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino});

  String mensagemRemoverEntidade(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino});
  String naoDeveSerPreenchido(String campo, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino});

  String nenhumaEntidadeEncontrada(String entidade);
  String nenhumEntidadeEncontrado(String entidade);

  String pesquiseUmaEntidade(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino});
  String selecioneO(String campo, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino});

  String selecioneUm(String campo, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino});
}
