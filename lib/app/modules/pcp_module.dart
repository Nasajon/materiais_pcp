import 'package:ana_l10n/ana_localization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_core/ana_core.dart';
import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';
import 'package:pcp_flutter/app/core/constants/local_db_key.dart';
import 'package:pcp_flutter/app/core/constants/app_localization.dart';
import 'package:pcp_flutter/app/core/stores/reducers/internet_connection_reducer.dart';
import 'package:pcp_flutter/app/modules/recursos/recursos_module.dart';
import 'package:pcp_flutter/app/modules/restricoes/restricoes_module.dart';

import 'presenter/widgets/card_widget.dart';

class PcpModule extends Module {
  static List<CardWidget> getCards(BuildContext context) {
    AppLocalization.l10n = context.l10nLocalization;

    return [
      ...RecursosModule.getCards(context),
      ...RestricoesModule.getCards(context),
    ];
  }

  @override
  List<Module> get imports => const [];

  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => HiveDatabaseService(boxName: LocalDBKeys.boxKey)),
        Bind.singleton((i) => CustomScaffoldController()),
        Bind.singleton((i) => InternetConnectionReducer(connectionStore: i(), scaffoldController: i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/recursos', module: RecursosModule()),
        ModuleRoute('/restricoes', module: RestricoesModule()),
      ];
}
