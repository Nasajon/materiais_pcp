import 'package:flutter_test/flutter_test.dart';
import 'package:pcp_flutter/app/modules/grupo_de_recurso/domain/entities/grupo_de_recurso.dart';

class GrupoDeRecursoFake extends Fake implements GrupoDeRecurso {
  @override
  final String? id;

  GrupoDeRecursoFake({this.id});
}
