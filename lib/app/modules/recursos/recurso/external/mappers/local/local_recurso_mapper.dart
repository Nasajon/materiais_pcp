import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/moeda_vo.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/recursos/recurso/domain/entities/recurso.dart';

class LocalRecursoMapper extends TypeAdapter<Recurso> {
  @override
  int get typeId => 1;

  @override
  Recurso read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return Recurso(
      id: fields[0],
      codigo: CodigoVO(fields[1]),
      descricao: TextVO(fields[2]),
      grupoDeRecurso: fields[3],
      custoHora: fields[4] != null ? MoedaVO(fields[4]) : null,
    );
  }

  @override
  void write(BinaryWriter writer, Recurso obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.codigo.value)
      ..writeByte(2)
      ..write(obj.descricao.value)
      ..writeByte(3)
      ..write(obj.grupoDeRecurso)
      ..writeByte(4)
      ..write(obj.custoHora?.value);
  }
}
