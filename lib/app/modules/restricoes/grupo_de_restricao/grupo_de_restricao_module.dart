import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/usecases/deletar_grupo_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/usecases/get_grupo_de_restricao_by_id_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/usecases/get_grupo_de_restricao_list_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/domain/usecases/save_grupo_de_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/external/datasources/local/grupo_de_restricao_local_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/external/datasources/remote/grupo_de_restricao_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/infra/repositories/grupo_de_restricao_repository_impl.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/controllers/grupo_de_restricao_controller.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/stores/grupo_de_restricao_form_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/stores/grupo_de_restricao_list_store.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/ui/pages/grupo_de_restricao_form_page.dart';
import 'package:pcp_flutter/app/modules/restricoes/grupo_de_restricao/presenter/ui/pages/grupo_de_restricao_list_page.dart';

class GrupoDeRestricaoModule extends NasajonModule {
  @override
  void addCards(CardManager manager) {
    manager.add(
      SimpleCardWidget(
        title: translation.titles.grupoDeRestricoes,
        section: 'PCP',
        code: 'materiais_pcp_grupo_de_restricao',
        descriptions: [],
        functions: [],
        permissions: [],
        showDemoMode: true,
        applicationID: 1,
        info: '',
        onPressed: () => Modular.to.pushNamed('/pcp/restricoes/grupo-de-restricao/'),
      ),
    );
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
