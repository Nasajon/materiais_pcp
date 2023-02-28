import 'package:flutter/cupertino.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import '../../core/modules/tipo_de_recurso/tipo_de_recurso_module.dart';
import '../presenter/widgets/card_widget.dart';
import 'domain/usecases/get_grupo_de_recurso_by_id_usecase.dart';
import 'domain/usecases/get_grupo_de_recurso_list_usecase.dart';
import 'domain/usecases/save_grupo_de_recurso_usecase.dart';
import 'external/datasources/grupo_de_recurso_datasource_impl.dart';
import 'infra/repositories/grupo_de_recurso_repository_impl.dart';
import 'presenter/stores/grupo_de_recurso_form_store.dart';
import 'presenter/stores/grupo_de_recurso_list_store.dart';
import 'presenter/ui/pages/mobile/grupo_de_recurso_form_mobile_page.dart';
import 'presenter/ui/pages/mobile/grupo_de_recurso_list_mobile_page.dart';
import 'presenter/ui/pages/web/grupo_de_recurso_form_desktop_page.dart';
import 'presenter/ui/pages/web/grupo_de_recurso_list_desktop_page.dart';
import 'presenter/ui/widgets/grupo_de_recurso_card.dart';

class GrupoDeRecursoModule extends Module {
  static List<CardWidget> getCards(BuildContext context) {
    return [GrupoDeRecursoCard(context: context)];
  }

  @override
  List<Module> get imports => [TipoDeRecursoModule()];

  @override
  List<Bind> get binds => [
        //DataSources
        Bind.lazySingleton((i) => GrupoDeRecursoDatasourceImpl(i())),
        Bind.lazySingleton((i) => GrupoDeRecursoDatasourceImpl(i()),
            export: true),

        //Repositories
        Bind.lazySingleton((i) => GrupoDeRecursoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GrupoDeRecursoRepositoryImpl(i()),
            export: true),

        //UseCases
        Bind.lazySingleton((i) => GetGrupoDeRecursoListUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRecursoByIdUsecaseImpl(i())),
        Bind.lazySingleton((i) => SaveGrupoDeRecursoUsecaseImpl(i())),

        Bind.lazySingleton((i) => GetGrupoDeRecursoListUsecaseImpl(i()),
            export: true),

        //Stores
        Bind.lazySingleton((i) => GrupoDeRecursoListStore(i())),
        Bind.lazySingleton((i) => GrupoDeRecursoFormStore(i(), i())),

        Bind.lazySingleton((i) => GrupoDeRecursoListStore(i()), export: true),
      ];

  @override
  List<ModularRoute> get routes => [
        ScreenRoute('/', screens: {
          600: (_, __) => GrupoDeRecursoListMobilePage(),
          992: (_, __) => GrupoDeRecursoListDesktopPage(),
          1280: (_, __) => GrupoDeRecursoListDesktopPage(),
        }),
        ScreenRoute('/new', screens: {
          600: (_, __) => const GrupoDeRecursoFormMobilePage(),
          992: (_, __) => const GrupoDeRecursoFormDesktopPage(),
          1280: (_, __) => const GrupoDeRecursoFormDesktopPage(),
        }),
        ScreenRoute('/:id', screens: {
          600: (_, args) => GrupoDeRecursoFormMobilePage(id: args.params['id']),
          992: (_, args) =>
              GrupoDeRecursoFormDesktopPage(id: args.params['id']),
          1280: (_, args) =>
              GrupoDeRecursoFormDesktopPage(id: args.params['id']),
        })
      ];
}
