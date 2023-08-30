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
  String get mensagemAdicioneAsAperacoes => 'Adicione as operações e defina os materiais e recursos utilizados em cada uma delas.';

  @override
  String get mensagemComoCriarRoteiro =>
      'Nos próximos passos você criará um novo roteiro.\nPrimeiramente, insira alguns dados básicos sobre este novo roteiro.';

  @override
  String get mensagemNaoEncontrouMaterial => 'Não encontrou o material que gostaria? Adicione outro de fora da ficha técnica.';

  @override
  String get mensagemSelecionePeriodoVigencia =>
      'Selecione o período de vigência durante o qual o roteiro de produção estará disponível para utilização';

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
  String criouUmaEntidadeComSucesso(String entidade) => 'Você criou uma ${entidade.toLowerCase()} com sucesso.';

  @override
  String criouUmEntidadeComSucesso(String entidade) => 'Você criou um ${entidade.toLowerCase()} com sucesso.';

  @override
  String editouUmaEntidadeComSucesso(String entidade) => 'Você editou uma ${entidade.toLowerCase()} com sucesso.';

  @override
  String editouUmEntidadeComSucesso(String entidade) => 'Você editou um ${entidade.toLowerCase()} com sucesso.';

  @override
  String erroDadosIncompletoOuAusenteDaEntidade(String entidade) =>
      'Os dados da ${entidade.toLowerCase()} estão incompletos ou não foram informados.';

  @override
  String erroDadosIncompletoOuAusenteDoEntidade(String entidade) =>
      'Os dados do ${entidade.toLowerCase()} estão incompletos ou não foram informados.';

  @override
  String excluirUmaEntidade(String entidade) =>
      'Você está prestes a excluir uma ${entidade.toLowerCase()}. Esta ação não poderá ser desfeita.';

  @override
  String excluirUmEntidade(String entidade) =>
      'Você está prestes a excluir um ${entidade.toLowerCase()}. Esta ação não poderá ser desfeita.';

  @override
  String excluiuUmaEntidadeComSucesso(String entidade) => 'Você excluiu uma ${entidade.toLowerCase()} com sucesso.';

  @override
  String excluiuUmEntidadeComSucesso(String entidade) => 'Você excluiu um ${entidade.toLowerCase()} com sucesso.';

  @override
  String nenhumaEntidadeEncontrada(String entidade) => 'Nenhuma ${entidade.toLowerCase()} encontrada.';

  @override
  String nenhumEntidadeEncontrado(String entidade) => 'Nenhum ${entidade.toLowerCase()} encontrado.';

  @override
  String get mensagemAdicioneUmaOuMaisRestricoes => 'Adicione uma ou mais restrições e, então, elas aparecerão aqui.';
}
