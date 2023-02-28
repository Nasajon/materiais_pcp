import 'package:flutter_global_dependencies/flutter_global_dependencies.dart';

import 'domain/usecases/get_tipo_de_recurso_list_usecase.dart';
import 'presenter/stores/tipo_de_recurso_list_store.dart';

class TipoDeRecursoModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => GetTipoDeRecursoListUsecaseImpl(),
            export: true),
        Bind.lazySingleton((i) => TipoDeRecursoListStore(i()), export: true),
      ];
}
