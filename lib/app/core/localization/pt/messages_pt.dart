import 'package:pcp_flutter/app/core/localization/enums/artigo_enum.dart';
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
  String get erroCapacidadeMaximaMaiorTotal => 'A capacidade máxima não pode ser maior que a total.';

  @override
  String get erroCapacidadeMaximaMenorMinima => 'A capacidade máxima precisa ser maior que a mínima.';

  @override
  String get erroCapacidadeMinimaMaiorMaxima => 'A capacidade mínima não pode ser maior que a máxima.';

  @override
  String get erroCapacidadeMinimaMaiorTotal => 'A capacidade mínima não pode ser maior que a total.';

  @override
  String get erroIdNaoInformado => 'ID não encontrado. Verifique se o ID fornecido é válido.';

  @override
  String get errorCampoObrigatorio => 'Este campo precisa estar preenchido';

  @override
  String get mensagemAdicioneAsAperacoes => 'Adicione as operações e defina os materiais e recursos utilizados em cada uma delas.';

  @override
  String get mensagemAdicioneUmaOperacao => 'Adicione, no mínimo, uma operação.';

  @override
  String get mensagemAdicioneUmaOuMaisRestricoes => 'Adicione uma ou mais restrições e, então, elas aparecerão aqui.';

  @override
  String get mensagemAdicioneUmRecurso => 'Adicione, no mínimo, um recurso.';

  @override
  String get mensagemComoCriarRoteiro =>
      'Nos próximos passos você criará um novo roteiro.\nPrimeiramente, insira alguns dados básicos sobre este novo roteiro.';

  @override
  String get mensagemConfirmacaoDoRoteiro =>
      'Todos os dados necessários foram preenchidos. Verifique abaixo se todas as informações estão corretas e, caso estejam, confirme em Criar roteiro.';

  @override
  String get mensagemNaoEncontrouMaterial => 'Não encontrou o material que gostaria? Adicione outro de fora da ficha técnica.';

  @override
  String get mensagemSelecionePeriodoVigencia =>
      'Selecione o período de vigência durante o qual o roteiro de produção estará disponível para utilização';

  @override
  String get mensagemSelecioneUmaUnidadeDeMedida => 'Selecione uma unidade de medida para continuar.';

  @override
  String get naoHaResultadosParaPesquisa => 'Não há resultados para pesquisa.';

  @override
  String get nenhumaDisponibilidadeFoiAdicionada =>
      'Nenhuma disponibilidade foi adicionada.\nAdicione uma disponibilidade clicando no botão abaixo.';

  @override
  String get nenhumaFichaTecnicaEncontrada => 'Nenhuma ficha técnica foi encontrada';

  @override
  String get nenhumaIndisponibilidadeFoiAdicionada =>
      'Nenhuma indisponibilidade foi adicionada.\nAdicione uma indisponibilidade clicando no botão abaixo.';

  @override
  String get nenhumHorarioFoiAdicionada => 'Nenhum horário foi adicionado.\nAdicione um horário clicando no botão abaixo.';

  @override
  String get nenhumMaterialFoiAdicionado => 'Nenhum material foi adicionado\nAdicione um material clicando no botão abaixo.';

  @override
  String get nenhumTurnoTrabalhoEncontrado => 'Nenhum turno de trabalho encontrado.';

  @override
  String get pesquisarNomeOuPalavraChave => 'Pesquisar por nome ou palavra-chave.';

  @override
  String criouAEntidadeComSucesso(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino}) {
    return artigo == ArtigoEnum.artigoFeminino
        ? 'Você criou a ${entidade.toLowerCase()} com sucesso.'
        : 'Você criou o ${entidade.toLowerCase()} com sucesso.';
  }

  @override
  String criouUmaEntidadeComSucesso(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino}) {
    return artigo == ArtigoEnum.artigoFeminino
        ? 'Você criou uma ${entidade.toLowerCase()} com sucesso.'
        : 'Você criou um ${entidade.toLowerCase()} com sucesso.';
  }

  @override
  String editouAEntidadeComSucesso(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino}) {
    return artigo == ArtigoEnum.artigoFeminino
        ? 'Você editou a ${entidade.toLowerCase()} com sucesso.'
        : 'Você editou o ${entidade.toLowerCase()} com sucesso.';
  }

  @override
  String editouUmaEntidadeComSucesso(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino}) {
    return artigo == ArtigoEnum.artigoFeminino
        ? 'Você editou uma ${entidade.toLowerCase()} com sucesso.'
        : 'Você editou um ${entidade.toLowerCase()} com sucesso.';
  }

  @override
  String erroDadosIncompletoOuAusenteDaEntidade(String entidade) =>
      'Os dados da ${entidade.toLowerCase()} estão incompletos ou não foram informados.';

  @override
  String erroDadosIncompletoOuAusenteDoEntidade(String entidade) =>
      'Os dados do ${entidade.toLowerCase()} estão incompletos ou não foram informados.';

  @override
  String excluirAEntidade(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino}) {
    return artigo == ArtigoEnum.artigoFeminino
        ? 'Você está prestes a excluir a ${entidade.toLowerCase()}. Esta ação não poderá ser desfeita.'
        : 'Você está prestes a excluir o ${entidade.toLowerCase()}. Esta ação não poderá ser desfeita.';
  }

  @override
  String excluirUmaEntidade(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino}) {
    return artigo == ArtigoEnum.artigoFeminino
        ? 'Você está prestes a excluir uma ${entidade.toLowerCase()}. Esta ação não poderá ser desfeita.'
        : 'Você está prestes a excluir um ${entidade.toLowerCase()}. Esta ação não poderá ser desfeita.';
  }

  @override
  String excluiuAEntidadeComSucesso(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino}) {
    return artigo == ArtigoEnum.artigoFeminino
        ? 'Você excluiu a ${entidade.toLowerCase()} com sucesso.'
        : 'Você excluiu o ${entidade.toLowerCase()} com sucesso.';
  }

  @override
  String excluiuUmaEntidadeComSucesso(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino}) {
    return artigo == ArtigoEnum.artigoFeminino
        ? 'Você excluiu uma ${entidade.toLowerCase()} com sucesso.'
        : 'Você excluiu um ${entidade.toLowerCase()} com sucesso.';
  }

  @override
  String insiraO(String campo, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino}) {
    return artigo == ArtigoEnum.artigoMasculino ? 'Insira o ${campo.toLowerCase()}' : 'Insira a ${campo.toLowerCase()}';
  }

  @override
  String insiraUm(String campo, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino}) {
    return artigo == ArtigoEnum.artigoMasculino ? 'Insira um ${campo.toLowerCase()}' : 'Insira uma ${campo.toLowerCase()}';
  }

  @override
  String mensagemRemoverEntidade(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino}) {
    return 'Você está prestes a remover ${artigo == ArtigoEnum.artigoMasculino ? 'um' : 'uma'} ${entidade.toLowerCase()}. Esta ação não poderá ser desfeita.\n\nDeseja remover?';
  }

  @override
  String nenhumaEntidadeEncontrada(String entidade) => 'Nenhuma ${entidade.toLowerCase()} encontrada.';

  @override
  String nenhumEntidadeEncontrado(String entidade) => 'Nenhum ${entidade.toLowerCase()} encontrado.';

  @override
  String selecioneO(String campo, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino}) {
    return artigo == ArtigoEnum.artigoMasculino ? 'Selecione o ${campo.toLowerCase()}' : 'Selecione a ${campo.toLowerCase()}';
  }

  @override
  String selecioneUm(String campo, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino}) {
    return artigo == ArtigoEnum.artigoMasculino ? 'Selecione um ${campo.toLowerCase()}' : 'Selecione uma ${campo.toLowerCase()}';
  }

  @override
  String naoDeveSerPreenchido(String campo, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino}) {
    return artigo == ArtigoEnum.artigoMasculino
        ? 'O ${campo.toLowerCase()} não deve ser preenchido'
        : 'A ${campo.toLowerCase()} não deve ser preenchida';
  }
}
