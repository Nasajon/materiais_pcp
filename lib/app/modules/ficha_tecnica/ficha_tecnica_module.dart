import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/atualizar_ficha_tecnica_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/deletar_ficha_tecnica_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_ficha_tecnica_por_id_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_ficha_tecnica_recentes_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_produtos_por_ids_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_todas_unidades_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_todos_ficha_tecnica_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_todos_produtos_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/get_unidade_por_ids_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/usecases/inserir_ficha_tecnica_usecase.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/external/datasources/remotes/remote_ficha_tecnica_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/external/datasources/remotes/remote_produto_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/external/datasources/remotes/remote_unidade_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/infra/repositories/ficha_tecnica_repository_impl.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/infra/repositories/produto_repository_impl.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/infra/repositories/unidade_repository_impl.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/controllers/ficha_tecnica_form_controller.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/ficha_tecnica_list_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/get_ficha_tecnica_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/inserir_editar_ficha_tecnica_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/produtos_list_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/stores/unidades_list_store.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/ui/pages/ficha_tecnica_form_page.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/ui/pages/ficha_tecnica_list_page.dart';
import 'package:pcp_flutter/app/modules/ficha_tecnica/presenter/ui/pages/ficha_tecnica_visualizar_page.dart';

class FichaTecnicaModule extends NasajonModule {
  @override
  void addCards(CardManager manager) {
    manager.add(
      SimpleCardWidget(
        title: translation.titles.fichasTecnicas,
        section: 'PCP',
        code: 'materiais_pcp_ficha_tecnica',
        descriptions: [],
        functions: [],
        permissions: [],
        showDemoMode: true,
        applicationID: 1,
        info: '',
        onPressed: () => Modular.to.pushNamed(NavigationRouter.fichasTecnicasModule.path),
      ),
    );
  }

  @override
  List<Bind<Object>> get binds => [
        //Datasources
        Bind.lazySingleton((i) => RemoteUnidadeDatasourceImpl(i())),
        Bind.lazySingleton((i) => RemoteProdutoDatasourceImpl(i())),
        Bind.lazySingleton((i) => RemoteFichaTecnicaDatasourceImpl(i())),
        //Repositories
        Bind.lazySingleton((i) => FichaTecnicaRepositoryImpl(i())),
        Bind.lazySingleton((i) => UnidadeRepositoryImpl(i())),
        Bind.lazySingleton((i) => ProdutoRepositoryImpl(i())),

        //Usecase
        Bind.lazySingleton((i) => AtualizarFichaTecnicaUsecaseImpl(i())),
        Bind.lazySingleton((i) => DeletarFichaTecnicaUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetFichaTecnicaPorIdUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetFichaTecnicaRecenteUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetTodosFichaTecnicaUsecaseImpl(i())),
        Bind.lazySingleton((i) => InserirFichaTecnicaUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetProdutosPorIdsUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetTodosProdutosUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetUnidadesPorIdsUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetTodasUnidadesUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetFichaTecnicaPorIdStore(i())),
        //Controllers

        Bind.lazySingleton((i) => FichaTecnicaFormController()),
        //Stores
        Bind.lazySingleton((i) => FichaTecnicaListStore(i(), i(), i())),
        Bind.factory((i) => ProdutoListStore(i())),
        Bind.factory((i) => UnidadeListStore(i())),
        Bind.factory((i) => InserirEditarFichaTecnicaStore(i(), i(), i()))
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          NavigationRouter.startModule.module,
          child: (context, args) => FichaTecnicaListPage(
            connectionStore: context.read(),
            scaffoldController: context.read(),
            fichaTecnicaListStore: context.read(),
          ),
        ),
        ChildRoute(
          NavigationRouter.createModule.module,
          child: (context, args) => FichaTecnicaFormPage(
            produtoListStore: context.read(),
            unidadeListStore: context.read(),
            inserirEditarFichaTecnicaStore: context.read(),
            fichaTecnicaListStore: context.read(),
            fichaTecnicaFormController: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
        ChildRoute(
          NavigationRouter.updateModule.module,
          child: (context, args) => FichaTecnicaVisualizarPage(
            fichaTecnicaId: args.params['id'],
            produtoListStore: context.read(),
            unidadeListStore: context.read(),
            inserirEditarFichaTecnicaStore: context.read(),
            fichaTecnicaListStore: context.read(),
            getFichaTecnicaPorIdStore: context.read(),
            fichaTecnicaFormController: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
      ];
}
