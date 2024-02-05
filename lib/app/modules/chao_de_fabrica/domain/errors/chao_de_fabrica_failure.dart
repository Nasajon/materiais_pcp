import 'package:flutter_core/ana_core.dart';

class ChaoDeFabricaFailure extends Failure {
  ChaoDeFabricaFailure({
    required super.errorMessage,
    required super.stackTrace,
  });
}

class DatasourceChaoDeFabricaFailure extends ChaoDeFabricaFailure {
  DatasourceChaoDeFabricaFailure({
    required super.errorMessage,
    super.stackTrace,
  });
}

class IdNotFoundChaoDeFabricaFailure extends ChaoDeFabricaFailure {
  IdNotFoundChaoDeFabricaFailure({
    required super.errorMessage,
    super.stackTrace,
  });
}

class MapperChaoDeFabricaFailure extends ChaoDeFabricaFailure {
  MapperChaoDeFabricaFailure({
    required super.errorMessage,
    super.stackTrace,
  });
}
