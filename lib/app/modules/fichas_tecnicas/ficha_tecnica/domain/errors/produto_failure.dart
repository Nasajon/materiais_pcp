import 'package:flutter_core/ana_core.dart';

class ProdutoFailure extends Failure {
  ProdutoFailure({
    super.errorMessage,
    super.stackTrace,
    super.label = 'PCP Ficha Técnica',
    super.exception,
  });
}

class DatasourceProdutoFailure extends Failure {
  DatasourceProdutoFailure({
    super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class IdNotFoundProdutoFailure extends Failure {
  IdNotFoundProdutoFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class IncompleteOrMissingDataProdutoFailure extends Failure {
  IncompleteOrMissingDataProdutoFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}
