import '../entities/tipo_de_recurso.dart';

abstract class GetTipoDeRecursoListUsecase {
  List<TipoDeRecurso> call();
}

class GetTipoDeRecursoListUsecaseImpl implements GetTipoDeRecursoListUsecase {
  @override
  List<TipoDeRecurso> call() {
    return [
      TipoDeRecurso.equipamento(),
      TipoDeRecurso.maoDeObra(),
      TipoDeRecurso.postoDeTrabalho(),
      TipoDeRecurso.outros(),
    ];
  }
}
