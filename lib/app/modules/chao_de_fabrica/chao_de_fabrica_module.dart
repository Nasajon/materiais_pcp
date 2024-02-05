import 'package:design_system/design_system.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/navigation_router.dart';
import 'package:pcp_flutter/app/core/localization/localizations.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_continuar_atividade_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_encerrar_atividade_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_iniciar_atividade_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_iniciar_preparacao_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/chao_de_fabrica_pausar_atividade_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/get_chao_de_fabrica_atividade_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/get_chao_de_fabrica_centro_de_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/domain/usecases/get_chao_de_fabrica_recurso_usecase.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/datasources/remote/remote_chao_de_fabrica_atividade_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/datasources/remote/remote_get_chao_de_fabrica_centro_de_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/external/datasources/remote/remote_get_chao_de_fabrica_recurso_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/repositories/chao_de_fabrica_atividade_repository_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/repositories/get_chao_de_fabrica_centro_de_trabalho_repository_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/infra/repositories/get_chao_de_fabrica_recurso_repository_impl.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/controllers/chao_de_fabrica_filter_controller.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/pages/chao_de_fabrica_list_page.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/reducers/chao_de_fabrica_atividade_filter_reducer.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_centro_de_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_list_store.dart';
import 'package:pcp_flutter/app/modules/chao_de_fabrica/presenter/stores/chao_de_fabrica_recurso_store.dart';

class ChaoDeFabricaModule extends NasajonModule {
  @override
  void addCards(CardManager manager) {
    manager.add(
      SimpleCardWidget(
        title: translation.titles.chaoDeFabrica,
        section: 'PCP',
        code: 'materiais_pcp_roteiro',
        descriptions: [],
        functions: [],
        permissions: [],
        showDemoMode: true,
        applicationID: 291,
        info: '',
        onPressed: () => Modular.to.pushNamed(NavigationRouter.chaoDeFabricaModule.path),
      ),
    );
  }

  @override
  List<Bind<Object>> get binds => [
        // Datasources
        Bind.lazySingleton((i) => RemoteGetChaoDeFabricaCentroDeTrabalhoDatasourceImpl(clientService: i())),
        Bind.lazySingleton((i) => RemoteGetChaoDeFabricaRecursoDatasourceImpl(clientService: i())),
        Bind.lazySingleton((i) => RemoteChaoDeFabricaAtividadeDatasourceImpl(clientService: i())),

        // Repositories
        Bind.lazySingleton((i) => GetChaoDeFabricaCentroDeTrabalhoRepositoryImpl(remoteCentroDeTrabalhoDatasource: i())),
        Bind.lazySingleton((i) => GetChaoDeFabricaRecursoRepositoryImpl(remoteRecursoDatasource: i())),
        Bind.lazySingleton((i) => ChaoDeFabricaAtividadeRepositoryImpl(atividadeDatasource: i())),

        // Usecases
        Bind.lazySingleton((i) => ChaoDeFabricaContinuarAtividadeUsecaseImpl(atividadeRepository: i())),
        Bind.lazySingleton((i) => ChaoDeFabricaEncerrarAtividadeUsecaseImpl(atividadeRepository: i())),
        Bind.lazySingleton((i) => ChaoDeFabricaIniciarAtividadeUsecaseImpl(atividadeRepository: i())),
        Bind.lazySingleton((i) => ChaoDeFabricaIniciarPreparacaoUsecaseImpl(atividadeRepository: i())),
        Bind.lazySingleton((i) => ChaoDeFabricaPausarAtividadeUsecaseImpl(atividadeRepository: i())),
        Bind.lazySingleton((i) => GetChaoDeFabricaAtividadeUsecaseImpl(atividadeRepository: i())),
        Bind.lazySingleton((i) => GetChaoDeFabricaCentroDeTrabalhoUsecaseImpl(centroDeTrabalhoRepository: i())),
        Bind.lazySingleton((i) => GetChaoDeFabricaRecursoUsecaseImpl(RecursoRepository: i())),

        // Controllers
        Bind.singleton((i) => ChaoDeFabricaFilterController()),

        // Stores
        TripleBind.lazySingleton((i) => ChaoDeFabricaListStore(
              getChaoDeFabricaAtividadeUsecase: i(),
              iniciarPreparacaoUsecase: i(),
              iniciarAtividadeUsecase: i(),
              pausarAtividadeUsecase: i(),
              continuarAtividadeUsecase: i(),
              encerrarAtividadeUsecase: i(),
            )),
        TripleBind.lazySingleton((i) => ChaoDeFabricaCentroDeTrabalhoStore(getCentroDeTrabalhoUsecase: i())),
        TripleBind.lazySingleton((i) => ChaoDeFabricaRecursoStore(getRecursoUsecase: i())),

        // Reducers
        Bind.singleton(
          (i) => ChaoDeFabricaAtividadeFilterReducer(
            chaoDeFabricaFilterController: i(),
            chaoDeFabricaListStore: i(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          NavigationRouter.startModule.module,
          child: (context, _) => ChaoDeFabricaListPage(
            chaoDeFabricaListStore: context.read(),
            centroDeTrabalhoStore: context.read(),
            recursoStore: context.read(),
            chaoDeFabricaFilterController: context.read(),
          ),
        ),
      ];
}
