import 'package:flutter/foundation.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

const String centrosDeTrabalhos = '/centros-de-trabalhos';
const String chaoDeFabrica = '/chao-de-fabrica';
const String fichasTecnicas = '/fichas-tecnicas';
const String gruposDeRecursos = '/grupos-de-recursos';
const String gruposDeRestricoes = '/grupos-de-restricoes';
const String ordensDeProducoes = '/ordens-de-producoes';
const String ordensDeProducoesSequenciamento = '$updateId/sequenciamento';
const String pcp = '/pcp';
const String recursos = '/recursos';
const String restricoes = '/restricoes';
const String roteiros = '/roteiros';
const String roteirosOperacao = '/operacao';
const String turnosDeTrabalhos = '/turnos-de-trabalhos';
const String updateId = '/:id';

void checkPreviousRouteWeb(String previousRoute) {
  final hasPreviousScreen = Modular.to.canPop();
  if (kIsWeb && !hasPreviousScreen) {
    if (previousRoute.isNotEmpty) {
      Modular.to.navigate(previousRoute);
    }
  } else {
    Modular.to.pop();
  }
}

enum NavigationRouter {
  appModule(module: '/app', path: '/app'),
  startModule(module: '/', path: '/'),
  createModule(module: '/new', path: '/'),
  updateModule(module: updateId, path: '/'),
  centrosDeTrabalhosModule(module: centrosDeTrabalhos, path: '$pcp$centrosDeTrabalhos'),
  chaoDeFabricaModule(module: chaoDeFabrica, path: '$pcp$chaoDeFabrica'),
  fichasTecnicasModule(module: fichasTecnicas, path: '$pcp$fichasTecnicas'),
  gruposDeRecursosModule(module: gruposDeRecursos, path: '$pcp$gruposDeRecursos'),
  gruposDeRestricoesModule(module: gruposDeRestricoes, path: '$pcp$gruposDeRestricoes'),
  ordensDeProducoesModule(module: ordensDeProducoes, path: '$pcp$ordensDeProducoes'),
  ordensDeProducoesSequenciamentoModule(
    module: ordensDeProducoesSequenciamento,
    path: '$pcp$ordensDeProducoes$ordensDeProducoesSequenciamento',
  ),
  recursosModule(module: recursos, path: '$pcp$recursos'),
  roteirosModule(module: roteiros, path: '$pcp$roteiros'),
  restricoesModule(module: restricoes, path: '$pcp$restricoes'),
  roteirosOperacaoModule(module: roteirosOperacao, path: '$pcp$roteiros$roteirosOperacao'),
  turnosDeTrabalhosModule(module: turnosDeTrabalhos, path: '$pcp$turnosDeTrabalhos');

  final String module;
  final String path;

  const NavigationRouter({required this.module, required this.path});

  String get createPath => '$path${createModule.module}';

  String updatePath(String id) {
    if (path.contains(updateId)) {
      return path.replaceAll(updateId, '/$id');
    }

    return '$path/$id';
  }
}
