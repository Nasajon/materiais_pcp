import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/deletar_roteiro_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/editar_roteiro_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_centro_de_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_ficha_tecnica_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_grupo_de_recurso_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_grupo_de_restricao_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_material_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_produto_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_recurso_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_restricao_por_grupo_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_roteiro_por_id_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_roteiro_recente_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_roteiro_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/get_unidade_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/domain/usecases/inserir_roteiro_usecase.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_get_centro_de_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_get_ficha_tecnica_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_get_grupo_de_recurso_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_get_grupo_de_restricao_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_get_material_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_get_produto_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_get_recurso_por_grupo_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_get_restricao_por_grupo_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_get_unidade_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/external/datasource/remotes/remote_roteiro_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_centro_de_trabalho_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_ficha_tecnica_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_grupo_de_recurso_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_grupo_de_restricao_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_material_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_produto_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_recurso_por_grupo_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_restricao_por_grupo_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/get_tipo_unidade_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/infra/repositories/roteiro_repository_impl.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/operacao_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/controllers/roteiro_controller.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_ficha_tecnica_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_recurso_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_grupo_de_restricao_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_material_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_produto_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_roteiro_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/get_unidade_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/inserir_editar_roteiro_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/stores/roteiro_list_store.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/roteiro_form_operacao_page.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/roteiro_form_page.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/roteiro_list_page.dart';
import 'package:pcp_flutter/app/modules/roteiros/roteiro/presenter/ui/pages/roteiro_visualizar_page.dart';

class RoteiroModule extends NasajonModule {
  @override
  void addCards(CardManager manager) {
    manager.add(
      SimpleCardWidget(
        title: translation.titles.roteiroDeProducao,
        section: 'PCP',
        code: 'materiais_pcp_roteiro',
        descriptions: [],
        functions: [],
        permissions: [],
        showDemoMode: true,
        applicationID: 1,
        info: '',
        onPressed: () => Modular.to.pushNamed('/pcp/roteiro/'),
      ),
    );
  }

  @override
  List<Bind<Object>> get binds => [
        // Centro de trabalho
        Bind.lazySingleton((i) => RemoteGetCentroDeTrabalhoDatasourceImpl(i())),
        Bind.lazySingleton((i) => GetCentroDeTrabalhoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetCentroDeTrabalhoUsecaseImpl(i())),

        // Ficha tecnica
        Bind.lazySingleton((i) => RemoteGetFichaTecnicaDatasourceImpl(i())),
        Bind.lazySingleton((i) => GetFichaTecnicaRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetFichaTecnicaUsecaseImpl(i())),

        // Grupo de recurso
        Bind.lazySingleton((i) => RemoteGetGrupoDeRecursoDatasourceImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRecursoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRecursoUsecaseImpl(i())),

        // Recurso
        Bind.lazySingleton((i) => RemoteGetRecursoPorGrupoDatasourceImpl(i())),
        Bind.lazySingleton((i) => GetRecursoPorGrupoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetRecursoPorGrupoUsecaseImpl(i())),

        // Grupo de restricao
        Bind.lazySingleton((i) => RemoteGetGrupoDeRestricaoDatasourceImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRestricaoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetGrupoDeRestricaoUsecaseImpl(i())),

        // Restricao
        Bind.lazySingleton((i) => RemoteGetRestricaoPorGrupoDatasourceImpl(i())),
        Bind.lazySingleton((i) => GetRestricaoPorGrupoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetRestricaoPorGrupoUsecaseImpl(i())),

        // Material (Produtos)
        Bind.lazySingleton((i) => RemoteGetMaterialDatasourceImpl(i())),
        Bind.lazySingleton((i) => GetMaterialRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetMaterialUsecaseImpl(i())),

        // Produtos
        Bind.lazySingleton((i) => RemoteGetProdutoDatasourceImpl(i())),
        Bind.lazySingleton((i) => GetProdutoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetProdutoUsecaseImpl(i())),

        // Unidades
        Bind.lazySingleton((i) => RemoteGetUnidadeDatasourceImpl(i())),
        Bind.lazySingleton((i) => GetUnidadeRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetUnidadeUsecaseImpl(i())),

        // Roteiro
        Bind.lazySingleton((i) => RemoteRoteiroDatasourceImpl(i())),
        Bind.lazySingleton((i) => RoteiroRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetRoteiroPorIdUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetRoteiroRecenteUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetRoteiroUsecaseImpl(i())),
        Bind.lazySingleton((i) => InserirRoteiroUsecaseImpl(i())),
        Bind.lazySingleton((i) => EditarRoteiroUsecaseImpl(i())),
        Bind.lazySingleton((i) => DeletarRoteiroUsecaseImpl(i())),

        // Stores
        Bind.lazySingleton((i) => GetCentroDeTrabalhoStore(i())),
        Bind.lazySingleton((i) => GetFichaTecnicaStore(i())),
        Bind.lazySingleton((i) => GetGrupoDeRecursoStore(i())),
        Bind.lazySingleton((i) => GetGrupoDeRestricaoStore(i())),
        Bind.lazySingleton((i) => GetProdutoStore(i())),
        Bind.lazySingleton((i) => GetUnidadeStore(i())),
        Bind.lazySingleton((i) => GetMaterialStore(i())),
        Bind.lazySingleton((i) => GetRoteiroStore(i())),
        Bind.lazySingleton((i) => RoteiroListStore(i(), i(), i())),
        Bind.factory((i) => InserirEditarRoteiroStore(i(), i(), i())),

        //Controllers
        Bind.factory((i) => RoteiroController()),
        Bind.lazySingleton((i) => OperacaoController(i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => RoteiroListPage(
            roteiroListStore: context.read(),
            scaffoldController: context.read(),
            connectionStore: context.read(),
          ),
        ),
        ChildRoute(
          '/new',
          child: (context, args) => RoteiroFormPage(
            roteiroListStore: context.read(),
            inserirEditarRoteiroStore: context.read(),
            getCentroDeTrabalhoStore: context.read(),
            getFichaTecnicaStore: context.read(),
            getGrupoDeRecursoStore: context.read(),
            getGrupoDeRestricaoStore: context.read(),
            getProdutoStore: context.read(),
            getUnidadeStore: context.read(),
            roteiroController: context.read(),
            operacaoController: context.read(),
            scaffoldController: context.read(),
            connectionStore: context.read(),
            getMaterialStore: context.read(),
          ),
        ),
        ChildRoute(
          '/:id',
          child: (context, args) => RoteiroVisualizarPage(
            roteiroId: args.params['id'],
            getRoteiroStore: context.read(),
            roteiroListStore: context.read(),
            inserirEditarRoteiroStore: context.read(),
            getCentroDeTrabalhoStore: context.read(),
            getFichaTecnicaStore: context.read(),
            getGrupoDeRecursoStore: context.read(),
            getGrupoDeRestricaoStore: context.read(),
            getProdutoStore: context.read(),
            getUnidadeStore: context.read(),
            roteiroController: context.read(),
            operacaoController: context.read(),
            scaffoldController: context.read(),
            connectionStore: context.read(),
            getMaterialStore: context.read(),
          ),
        ),
        ChildRoute(
          '/operacao',
          child: (context, args) => RoteiroFormOperacaoPage(
            operacaoController: context.read(),
            getUnidadeStore: context.read(),
            getCentroDeTrabalhoStore: context.read(),
            getProdutoStore: context.read(),
            getMaterialStore: context.read(),
            getGrupoDeRecursoStore: context.read(),
            getGrupoDeRestricaoStore: context.read(),
          ),
        )
      ];
}
