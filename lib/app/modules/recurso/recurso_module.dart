import 'package:flutter/cupertino.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import '../../core/modules/tipo_de_recurso/tipo_de_recurso_module.dart';
import '../grupo_de_recurso/grupo_de_recurso_module.dart';
import '../presenter/widgets/card_widget.dart';
import 'domain/usecases/get_recurso_by_usecase_id.dart';
import 'domain/usecases/get_recurso_usecase_list.dart';
import 'domain/usecases/save_recurso_usecase.dart';
import 'external/datasources/recurso_datasource_impl.dart';
import 'infra/repositories/recurso_repository_impl.dart';
import 'presenter/stores/recurso_form_store.dart';
import 'presenter/stores/recurso_list_store.dart';
import 'presenter/ui/pages/mobile/recurso_form_mobile_page.dart';
import 'presenter/ui/pages/mobile/recurso_list_mobile_page.dart';
import 'presenter/ui/pages/web/recurso_form_desktop_page.dart';
import 'presenter/ui/pages/web/recurso_list_desktop_page.dart';
import 'presenter/ui/widgets/recurso_card.dart';

class RecursoModule extends Module {
  static List<CardWidget> getCards(BuildContext context) {
    return [RecursoCard(context: context)];
  }

  @override
  List<Module> get imports => [TipoDeRecursoModule(), GrupoDeRecursoModule()];

  @override
  List<Bind> get binds => [
        //DataSources
        Bind.lazySingleton((i) => RecursoDatasourceImpl(i())),

        //Repositories
        Bind.lazySingleton((i) => RecursoRepositoryImpl(i())),

        //UseCases
        Bind.lazySingleton((i) => GetGetRecursoListUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetRecursoByIdUsecaseImpl(i())),
        Bind.lazySingleton((i) => SaveRecursoUsecaseImpl(i())),

        //Stores
        Bind.lazySingleton((i) => RecursoListStore(i())),
        Bind.lazySingleton((i) => RecursoFormStore(i(), i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ScreenRoute('/', screens: {
          600: (_, __) => RecursoListMobilePage(),
          992: (_, __) => RecursoListDesktopPage(),
          1280: (_, __) => RecursoListDesktopPage(),
        }),
        ScreenRoute('/new', screens: {
          600: (_, __) => const RecursoFormMobilePage(),
          992: (_, __) => const RecursoFormDesktopPage(),
          1280: (_, __) => const RecursoFormDesktopPage(),
        }),
        ScreenRoute('/:id', screens: {
          600: (_, args) => RecursoFormMobilePage(id: args.params['id']),
          992: (_, args) => RecursoFormDesktopPage(id: args.params['id']),
          1280: (_, args) => RecursoFormDesktopPage(id: args.params['id']),
        }),
      ];
}
