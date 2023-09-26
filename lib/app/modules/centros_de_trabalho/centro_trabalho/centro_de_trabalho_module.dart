import 'package:flutter/widgets.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/atualizar_centro_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/deletar_centro_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/get_centro_trabalho_por_id_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/get_centro_trabalho_recente_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/get_todos_centro_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/get_turno_centro_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/get_turno_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/domain/usecases/inserir_centro_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/external/datasources/remotes/remote_centro_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/external/datasources/remotes/remote_get_turno_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/infra/repositories/centro_trabalho_repository_impl.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/infra/repositories/get_turno_trabalho_repository_impl.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/presenter/controllers/centro_trabalho_controller.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/presenter/redurces/get_turno_trabalho_reduce.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/presenter/stores/centro_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/presenter/stores/inserir_editar_centro_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/presenter/ui/pages/centro_trabalho_form_page.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/presenter/ui/pages/centro_trabalho_list_page.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/centro_trabalho/presenter/ui/widgets/centro_de_trabalho_card.dart';
import 'package:pcp_flutter/app/modules/presenter/presenter.dart';

class CentroDeTrabalhoModule extends Module {
  static List<CardWidget> getCards(BuildContext context) {
    return [CentroDeTrabalhoCard(context: context)];
  }

  @override
  List<Bind<Object>> get binds => [
        //Datasources
        Bind.lazySingleton((i) => RemoteCentroTrabalhoDatasourceImpl(i())),
        Bind.lazySingleton((i) => RemoteGetTurnoTrabalhoDatasourceImpl(i())),

        //Repositories
        Bind.lazySingleton((i) => CentroTrabalhoRepositoryImpl(i())),
        Bind.lazySingleton((i) => GetTurnoTrabalhoRepositoryImpl(i())),

        //Usecase
        Bind.lazySingleton((i) => GetCentroTrabalhoRecenteUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetTodosCentroTrabalhoUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetCentroTrabalhoPorIdUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetTurnoCentroTrabalhoUsecaseImpl(i())),
        Bind.lazySingleton((i) => InserirCentroTrabalhoUsecaseImpl(i())),
        Bind.lazySingleton((i) => AtualizarCentroTrabalhoUsecaseImpl(i())),
        Bind.lazySingleton((i) => DeletarCentroTrabalhoUsecaseImpl(i())),
        Bind.lazySingleton((i) => GetTurnoTrabalhoUsecaseImpl(i())),

        //Controllers
        Bind.singleton((i) => CentroTrabalhoController()),

        //Reducers
        Bind.singleton((i) => GetTurnoTrabalhoReducer(i(), i())),

        //Stores
        TripleBind.lazySingleton((i) => CentroTrabalhoListStore(i(), i())),
        TripleBind.factory((i) => InserirEditarCentroTrabalhoStore(i(), i(), i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => CentroTrabalhoListPage(
            centroTrabalhoListStore: context.read(),
            scaffoldController: context.read(),
            connectionStore: context.read(),
          ),
        ),
        ChildRoute(
          '/new',
          child: (context, args) => CentroTrabalhoFormPage(
            inserirEditarCentroTrabalhoStore: context.read(),
            centroTrabalhoListStore: context.read(),
            centroTrabalhoController: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
        ChildRoute(
          '/:id',
          child: (context, args) => CentroTrabalhoFormPage(
            id: args.params['id'],
            inserirEditarCentroTrabalhoStore: context.read(),
            centroTrabalhoListStore: context.read(),
            centroTrabalhoController: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
      ];
}
