import 'package:flutter_core/ana_core.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/text_vo.dart';
import 'package:pcp_flutter/app/modules/restricoes/common/domain/entities/grupo_de_restricao_entity.dart';
import 'package:pcp_flutter/app/core/modules/domain/value_object/codigo_vo.dart';

class LocalGrupoDeRestricaoMapper extends TypeAdapter<GrupoDeRestricaoEntity> {
  @override
  int get typeId => 4;

  @override
  GrupoDeRestricaoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return GrupoDeRestricaoEntity(
      id: fields[0],
      codigo: CodigoVO(fields[1]),
      descricao: TextVO(fields[2]),
      tipo: fields[3],
    );
  }

  @override
  void write(BinaryWriter writer, GrupoDeRestricaoEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.codigo?.value)
      ..writeByte(2)
      ..write(obj.descricao.value)
      ..writeByte(3)
      ..write(obj.tipo);
  }
}
