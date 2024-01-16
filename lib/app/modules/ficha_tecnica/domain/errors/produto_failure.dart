import 'package:pcp_flutter/app/modules/ficha_tecnica/domain/errors/ficha_tecnica_failure.dart';

class ProdutoFailure extends FichaTecnicaFailure {
  ProdutoFailure({
    super.errorMessage,
    super.stackTrace,
    super.label = 'PCP Ficha Técnica',
    super.exception,
  });
}

class DatasourceProdutoFailure extends ProdutoFailure {
  DatasourceProdutoFailure({
    super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class IdNotFoundProdutoFailure extends ProdutoFailure {
  IdNotFoundProdutoFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}

class IncompleteOrMissingDataProdutoFailure extends ProdutoFailure {
  IncompleteOrMissingDataProdutoFailure({
    required super.errorMessage,
    super.stackTrace,
    super.exception,
  });
}
