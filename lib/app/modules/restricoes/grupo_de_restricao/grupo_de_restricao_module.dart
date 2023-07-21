import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/presenter/widgets/card_widget.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/usecases/deletar_grupo_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/usecases/get_grupo_de_restricao_by_id_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/usecases/get_grupo_de_restricao_list_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/usecases/save_grupo_de_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/external/datasources/local/grupo_de_restricao_local_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/external/datasources/remote/grupo_de_restricao_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/infra/repositories/grupo_de_restricao_repository_impl.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/controllers/grupo_de_restricao_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/stores/deletar_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/stores/grupo_de_restricao_form_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/stores/grupo_de_restricao_list_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/ui/pages/grupo_de_restricao_form_page.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/ui/pages/grupo_de_restricao_list_page.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/ui/widgets/grupo_de_restricao_card.dart';

class GrupoDeRestricaoModule extends Module {
  static List<CardWidget> getCards(BuildContext context) {
    return [GrupoDeRestricaoCard(context: context)];
  }

  @override
  List<Bind> get binds => [
        //DataSources
        Bind.lazySingleton((i) => GrupoDeRestricaoDatasourceImpl(i())),
        Bind.lazySingleton((i) => GrupoDeRestricaoLocalDatasourceImpl(i())),

        //Repositories
        Bind.lazySingleton((i) => GrupoDeRestricaoRepositoryImpl(i(), i(), i())),

        //UseCases
        Bind.lazySingleton((i) => GetGrupoDeRestricaoListUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRestricaoByIdUsecaseImpl(i())),
        Bind.lazySingleton((i) => SaveGrupoDeRestricaoUsecaseImpl(i())),
        Bind.lazySingleton((i) => DeletarGrupoDeRestricaoUsecaseImpl(i())),

        //Stores
        TripleBind.lazySingleton((i) => GrupoDeRestricaoListStore(i(), i())),
        TripleBind.factory((i) => GrupoDeRestricaoFormStore(i(), i())),

        //Controller
        Bind.lazySingleton((i) => GrupoDeRestricaoController())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => GrupoDeRestricaoListPage(
            grupoDeRestricaoStore: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
        ChildRoute(
          '/new',
          child: (context, args) => GrupoDeRestricaoFormPage(
            grupoDeRestricaoFormStore: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
            grupoDeRestricaoController: context.read(),
          ),
        ),
        ChildRoute(
          '/:id',
          child: (context, args) => GrupoDeRestricaoFormPage(
            id: args.params['id'],
            grupoDeRestricaoFormStore: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
            grupoDeRestricaoController: context.read(),
          ),
        ),
      ];
}
