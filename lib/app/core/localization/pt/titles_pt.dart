import 'package:pcp_flutter/app/core/localization/enums/artigo_enum.dart';
import 'package:pcp_flutter/app/core/localization/titles.dart';

class TitlesPt extends Titles {
  @override
  String get adicionarDisponibilidade => 'Adicionar disponibilidade';

  @override
  String get adicionarGrupoDeRecurso => 'Adicionar grupo de recursos';

  @override
  String get adicionarGrupoDeRestricoes => 'Adicionar grupo de restrições';

  @override
  String get adicionarHorario => 'Adicionar horário';

  @override
  String get adicionarIndisponibilidade => 'Adicionar indisponibilidade';

  @override
  String get adicionarMateriais => 'Adicionar materiais';

  @override
  String get adicionarMaterial => 'Adicionar material';

  @override
  String get adicionarOperacao => 'Adicionar operação';
  @override
  String get adicioneUmaDisponibilidade => 'Adicione uma disponibilidade';

  @override
  String get adicioneUmaIndisponibilidade => 'Adicione uma indisponibilidade';

  @override
  String get adicioneUmHorario => 'Adicione um horário';

  @override
  String get adicioneUmMaterial => 'Adicione um material';

  @override
  String get centroDeTrabalho => 'Centro de trabalho';

  @override
  String get centrosDeTrabalho => 'Centros de trabalho';

  @override
  String get criarCentroDeTrabalho => 'Criar centro de trabalho';

  @override
  String get criarFichaTecnica => 'Criar ficha técnica';

  @override
  String get criarGrupoDeRecursos => 'Criar grupo de recursos';

  @override
  String get criarGrupoDeRestricoes => 'Criar grupo de restrições';

  @override
  String get criarRecurso => 'Criar recurso';

  @override
  String get criarRestricaoSecundaria => 'Criar restrição secundária';

  @override
  String get criarTurnoDeTrabalho => 'Criar turno de trabalho';

  @override
  String get dadosBasicos => 'Dados básicos';

  @override
  String get descartarAlteracoes => 'Descartar as informações?';

  @override
  String get desejaExcluir => 'Deseja excluir?';

  @override
  String get editarDisponibilidade => 'Editar disponibilidade';

  @override
  String get editarHorario => 'Editar horário';

  @override
  String get editarIndisponibilidade => 'Editar indisponibilidade';

  @override
  String get editarMaterial => 'Editar material';

  @override
  String get editarOperacao => 'Editar operação';

  @override
  String get fichasTecnicas => 'Fichas técnicas';

  @override
  String get fichaTecnica => 'Ficha técnica';

  @override
  String get grupoDeRestricoes => 'Grupos de restrições';

  @override
  String get gruposDeRecursos => 'Grupos de recursos';

  @override
  String get gruposDeRestricao => 'Grupos de restrição';

  @override
  String get materiais => 'Materiais';

  @override
  String get ordemDeProducao => 'Ordem de produção';

  @override
  String get planejarOrdem => 'Planejar ordem';

  @override
  String get restricoes => 'Restrições';

  @override
  String get restricoesSecundarias => 'Restrições secundárias';

  @override
  String get resultadoSequenciamento => 'Resultado do sequenciamento';

  @override
  String get roteiroDeProducao => 'Roteiros de produção';

  @override
  String get semRestricoes => 'Sem restrições';

  @override
  String get tituloRecursos => 'Recursos';

  @override
  String get tituloSemConexaoInternet => 'Sem conexão com a internet';

  @override
  String get turnosDeTrabalho => 'Turnos de trabalho';

  @override
  String get ultimasFichasTecnicasAcessadas => 'Ultimas fichas técnicas acessadas';

  @override
  String get ultimasOrdensDeProducaosAcessados => 'Últimas ordens de produtos acessados';

  @override
  String get ultimasRestricoesAcessadas => 'Últimas restrições acessadas';

  @override
  String get ultimoCentrosAcessados => 'Últimos centros acessados';

  @override
  String get ultimosCentrosAcessados => 'Últimos centros acessados';

  @override
  String get ultimosGruposAcessados => 'Últimos grupos acessados';

  @override
  String get ultimosRecursosAcessados => 'Últimos recursos acessados';

  @override
  String get ultimosRoteirosAcessados => 'Últimos roteiros acessados';

  @override
  String get ultimosTurnosAcessados => 'Últimos turnos acessados';

  @override
  String criarEntidade(String entidade) => 'Criar ${entidade.toLowerCase()}';

  @override
  String editarEntidade(String entidade) => 'Editar $entidade';

  @override
  String excluirEntidade(String entidade) => 'Excluir ${entidade.toLowerCase()}?';

  @override
  String removerEntidade(String entidade) {
    return 'Remover ${entidade.toLowerCase()}';
  }

  @override
  String get chaoDeFabrica => 'Chão de fábrica';

  @override
  String get minhasAtividades => 'Minhas atividades';

  @override
  String selecione(String entidade, {ArtigoEnum artigo = ArtigoEnum.artigoMasculino}) {
    if (artigo == ArtigoEnum.artigoMasculino) {
      return 'Selecione um ${entidade.toLowerCase()}';
    }

    return 'Selecione uma ${entidade.toLowerCase()}';
  }
}
