import 'package:flutter/material.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/usecases/deletar_turno_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/usecases/editar_turno_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/usecases/get_turno_trabalho_recentes_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/usecases/get_turno_trabalho_por_id_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/domain/usecases/inserir_turno_trabalho_usecase.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/external/datasources/remote/turno_trabalho_datasource_impl.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/infra/repositories/turno_trabalho_repository_impl.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/controller/turno_trabalho_form_controller.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/deletar_turno_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/get_turno_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/inserir_editar_turno_trabalho_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/stores/turno_trabalho_list_store.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/mobile/mobile_criar_editar_horario_page.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/turno_trabalho_form_page.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/turno_trabalho_list_page.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/turno_trabalho_visualizar_page.dart';
import 'package:pcp_flutter/app/modules/centros_de_trabalho/turno_de_trabalho/presenter/ui/widgets/turno_de_trabalho_card.dart';
import 'package:pcp_flutter/app/modules/presenter/presenter.dart';

class TurnoDeTrabalhoModule extends Module {
  static List<CardWidget> getCards(BuildContext context) {
    return [TurnoDeTranalhoCard(context: context)];
  }

  @override
  List<Bind> get binds => [
        //Datasources
        Bind.lazySingleton((i) => TurnoTrabalhoDatasourceImpl(i())),

        //Repositories
        Bind.lazySingleton((i) => TurnoTrabalhoRepositoryImpl(i())),

        //Usecases
        Bind.lazySingleton((i) => GetTurnoTrabalhoUsecasePorIdImpl(i())),
        Bind.lazySingleton((i) => GetTurnoTrabalhoRecenteUsecaseImpl(i())),
        Bind.lazySingleton((i) => InserirTurnoTrabalhoUsecaseImpl(i())),
        Bind.lazySingleton((i) => EditarTurnoTrabalhoUsecaseImpl(i())),
        Bind.lazySingleton((i) => DeletarTurnoTrabalhoUsecaseImpl(i())),

        //Stores
        TripleBind.lazySingleton((i) => TurnoTrabalhoListStore(i(), i())),
        TripleBind.lazySingleton((i) => GetTurnoTrabalhoPorIdStore(i())),
        TripleBind.factory((i) => InserirEditarTurnoTrabalhoStore(i(), i())),

        //Controllers
        Bind.lazySingleton((i) => TurnoTrabalhoFormController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => TurnoTrabalhoListPage(
            turnoTrabalhoListStore: context.read(),
            scaffoldController: context.read(),
            connectionStore: context.read(),
          ),
        ),
        ChildRoute(
          '/new',
          child: (context, args) => TurnoTrabalhoFormPage(
            inserirEditarTurnoTrabalhoStore: context.read(),
            turnoTrabalhoListStore: context.read(),
            turnoTrabalhoFormController: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
        ChildRoute(
          '/:id/visualizar',
          child: (context, args) => TurnoTrabalhoVisualizarPage(
            id: args.params['id'],
            inserirEditarTurnoTrabalhoStore: context.read(),
            turnoTrabalhoListStore: context.read(),
            getTurnoTrabalhoPorIdStore: context.read(),
            turnoTrabalhoFormController: context.read(),
            connectionStore: context.read(),
            scaffoldController: context.read(),
          ),
        ),
      ];
}
