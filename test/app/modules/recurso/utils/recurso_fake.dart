import 'package:flutter_test/flutter_test.dart';
import 'package:pcp_flutter/app/modules/recurso/domain/entities/recurso.dart';

class RecursoFake extends Fake implements Recurso {
  @override
  final String? id;

  RecursoFake({this.id});
}
