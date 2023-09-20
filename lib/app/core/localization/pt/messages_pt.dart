import 'package:pcp_flutter/app/core/localization/enums/artigo.dart';
import 'package:pcp_flutter/app/core/localization/messages.dart';

class MessagesPt extends Messages {
  @override
  String get avisoPesquisarPorNomeOuPalavraChave => 'Pesquisar por nome ou palavra-chave';

  @override
  String get avisoSemConexaoInternet =>
      'Parece que você está sem conexão com a internet. O sistema continuará trabalhando mesmo sem conexão';

  @override
  String get descatarAlteracoesCriacaoEntidade => 'Você preencheu os campos. Tem certeza que deseja sair e descartar as alterações?';

  @override
  String get descatarAlteracoesEdicaoEntidade => 'Você fez alterações nos campos. Tem certeza que deseja sair e descartar as alterações?';

  @override
  String get erroIdNaoInformado => 'ID não encontrado. Verifique se o ID fornecido é válido.';

  @override
  String get errorCampoObrigatorio => 'Este campo precisa estar preenchido';

  @override
  String get naoHaResultadosParaPesquisa => 'Não há resultados para pesquisa.';

  @override
  String get nenhumaDisponibilidadeFoiAdicionada =>
      'Nenhuma disponibilidade foi adicionada.\nAdicione uma disponibilidade clicando no botão abaixo.';

  @override
  String get nenhumaIndisponibilidadeFoiAdicionada =>
      'Nenhuma indisponibilidade foi adicionada.\nAdicione uma indisponibilidade clicando no botão abaixo.';

  @override
  String get nenhumHorarioFoiAdicionada => 'Nenhum horário foi adicionado.\nAdicione um horário clicando no botão abaixo.';

  @override
  String get nenhumTurnoTrabalhoEncontrado => 'Nenhum turno de trabalho encontrado.';

  @override
  String get pesquisarNomeOuPalavraChave => 'Pesquisar por nome ou palavra-chave.';

  @override
  String criouUmaEntidadeComSucesso(String entidade, ArtigoEnum artigo) {
    return artigo == ArtigoEnum.artigoFeminino
        ? 'Você criou uma ${entidade.toLowerCase()} com sucesso.'
        : 'Você criou um ${entidade.toLowerCase()} com sucesso.';
  }

  @override
  String criouAEntidadeComSucesso(String entidade, ArtigoEnum artigo) {
    return artigo == ArtigoEnum.artigoFeminino
        ? 'Você criou a ${entidade.toLowerCase()} com sucesso.'
        : 'Você criou o ${entidade.toLowerCase()} com sucesso.';
  }

  @override
  String editouUmaEntidadeComSucesso(String entidade, ArtigoEnum artigo) {
    return artigo == ArtigoEnum.artigoFeminino
        ? 'Você editou uma ${entidade.toLowerCase()} com sucesso.'
        : 'Você editou um ${entidade.toLowerCase()} com sucesso.';
  }

  @override
  String editouAEntidadeComSucesso(String entidade, ArtigoEnum artigo) {
    return artigo == ArtigoEnum.artigoFeminino
        ? 'Você editou a ${entidade.toLowerCase()} com sucesso.'
        : 'Você editou o ${entidade.toLowerCase()} com sucesso.';
  }

  @override
  String erroDadosIncompletoOuAusenteDaEntidade(String entidade) =>
      'Os dados da ${entidade.toLowerCase()} estão incompletos ou não foram informados.';

  @override
  String erroDadosIncompletoOuAusenteDoEntidade(String entidade) =>
      'Os dados do ${entidade.toLowerCase()} estão incompletos ou não foram informados.';

  @override
  String excluirUmaEntidade(String entidade, ArtigoEnum artigo) {
    return artigo == ArtigoEnum.artigoFeminino
        ? 'Você está prestes a excluir uma ${entidade.toLowerCase()}. Esta ação não poderá ser desfeita.'
        : 'Você está prestes a excluir um ${entidade.toLowerCase()}. Esta ação não poderá ser desfeita.';
  }

  @override
  String excluirAEntidade(String entidade, ArtigoEnum artigo) {
    return artigo == ArtigoEnum.artigoFeminino
        ? 'Você está prestes a excluir a ${entidade.toLowerCase()}. Esta ação não poderá ser desfeita.'
        : 'Você está prestes a excluir o ${entidade.toLowerCase()}. Esta ação não poderá ser desfeita.';
  }

  @override
  String excluiuUmaEntidadeComSucesso(String entidade, ArtigoEnum artigo) {
    return artigo == ArtigoEnum.artigoFeminino
        ? 'Você excluiu uma ${entidade.toLowerCase()} com sucesso.'
        : 'Você excluiu um ${entidade.toLowerCase()} com sucesso.';
  }

  @override
  String excluiuAEntidadeComSucesso(String entidade, ArtigoEnum artigo) {
    return artigo == ArtigoEnum.artigoFeminino
        ? 'Você excluiu a ${entidade.toLowerCase()} com sucesso.'
        : 'Você excluiu o ${entidade.toLowerCase()} com sucesso.';
  }

  @override
  String nenhumaEntidadeEncontrada(String entidade) => 'Nenhuma ${entidade.toLowerCase()} encontrada.';

  @override
  String nenhumEntidadeEncontrado(String entidade) => 'Nenhum ${entidade.toLowerCase()} encontrado.';

  @override
  String selecioneUm(String campo, ArtigoEnum artigo) {
    return artigo == ArtigoEnum.artigoMasculino ? 'Selecione um ${campo.toLowerCase()}' : 'Selecione uma ${campo.toLowerCase()}';
  }

  @override
  String insiraUm(String campo, ArtigoEnum artigo) {
    return artigo == ArtigoEnum.artigoMasculino ? 'Insira um ${campo.toLowerCase()}' : 'Insira uma ${campo.toLowerCase()}';
  }

  @override
  String selecioneO(String campo, ArtigoEnum artigo) {
    return artigo == ArtigoEnum.artigoMasculino ? 'Selecione o ${campo.toLowerCase()}' : 'Selecione a ${campo.toLowerCase()}';
  }

  @override
  String insiraO(String campo, ArtigoEnum artigo) {
    return artigo == ArtigoEnum.artigoMasculino ? 'Insira o ${campo.toLowerCase()}' : 'Insira a ${campo.toLowerCase()}';
  }

  @override
  String get nenhumMaterialFoiAdicionado => 'Nenhum material foi adicionado\nAdicione um material clicando no botão abaixo.';

  @override
  String get nenhumaFichaTecnicaEncontrada => 'Nenhuma ficha técnica foi encontrada';
}
